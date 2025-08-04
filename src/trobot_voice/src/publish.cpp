/*
* 语音听写(iFly Auto Transform)技术能够实时地将语音转换成对应的文字。
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "robot_voice/qisr.h"				//这里我们将头文件都放到了robot_voice/include/robot_voice文件夹内
#include "robot_voice/msp_cmn.h"
#include "robot_voice/msp_errors.h"
#include "robot_voice/speech_recognizer.h"

#include "ros/ros.h"						//调用ROS的头文件和发布消息类型的头文件
#include "std_msgs/String.h"

#define FRAME_LEN	640 
#define	BUFFER_SIZE	4096

int wakeupFlag   = 0 ;						//创建两个全局变量，wakeupFlag用来显示是否被唤醒；resultFlag标志有没有语音识别的结果
int resultFlag   = 0 ;
//跳转到main函数，其他函数大多没有修改都是科大讯飞给出的

/* Upload User words */
static int upload_userwords()
{
	char*			userwords	=	NULL;
	size_t			len			=	0;
	size_t			read_len	=	0;
	FILE*			fp			=	NULL;
	int				ret			=	-1;

	fp = fopen("userwords.txt", "rb");
	if (NULL == fp)										
	{
		printf("\nopen [userwords.txt] failed! \n");
		goto upload_exit;
	}

	fseek(fp, 0, SEEK_END);
	len = ftell(fp); 
	fseek(fp, 0, SEEK_SET);  					
	
	userwords = (char*)malloc(len + 1);
	if (NULL == userwords)
	{
		printf("\nout of memory! \n");
		goto upload_exit;
	}

	read_len = fread((void*)userwords, 1, len, fp); 
	if (read_len != len)
	{
		printf("\nread [userwords.txt] failed!\n");
		goto upload_exit;
	}
	userwords[len] = '\0';
	
	MSPUploadData("userwords", userwords, len, "sub = uup, dtt = userword", &ret); //ÉÏ´«ÓÃ»§´Ê±í
	if (MSP_SUCCESS != ret)
	{
		printf("\nMSPUploadData failed ! errorCode: %d \n", ret);
		goto upload_exit;
	}
	
upload_exit:
	if (NULL != fp)
	{
		fclose(fp);
		fp = NULL;
	}	
	if (NULL != userwords)
	{
		free(userwords);
		userwords = NULL;
	}
	
	return ret;
}


static void show_result(char *string, char is_over)
{
    resultFlag=1;
	printf("\rResult: [ %s ]", string);
	if(is_over)
		putchar('\n');
}

static char *g_result = NULL;
static unsigned int g_buffersize = BUFFER_SIZE;

void on_result(const char *result, char is_last)
{
	if (result) {
		size_t left = g_buffersize - 1 - strlen(g_result);
		size_t size = strlen(result);
		if (left < size) {
			g_result = (char*)realloc(g_result, g_buffersize + BUFFER_SIZE);
			//g_result就是识别后的结果
			if (g_result)
				g_buffersize += BUFFER_SIZE;
			else {
				printf("mem alloc failed\n");
				return;
			}
		}
		strncat(g_result, result, size);
		show_result(g_result, is_last);	//这里将结果显示出来，并在show_result函数中，把全局结果标志量resultFlag置位(1)，回看main函数
	}
}
void on_speech_begin()
{
	if (g_result)
	{
		free(g_result);
	}
	g_result = (char*)malloc(BUFFER_SIZE);
	g_buffersize = BUFFER_SIZE;
	memset(g_result, 0, g_buffersize);

	printf("Start Listening...\n");
}
void on_speech_end(int reason)
{
	if (reason == END_REASON_VAD_DETECT)
		printf("\nSpeaking done \n");
	else
		printf("\nRecognizer error %d\n", reason);
}

/* demo send audio data from a file */
static void demo_file(const char* audio_file, const char* session_begin_params)
{
	int	errcode = 0;
	FILE*	f_pcm = NULL;
	char*	p_pcm = NULL;
	unsigned long	pcm_count = 0;
	unsigned long	pcm_size = 0;
	unsigned long	read_size = 0;
	struct speech_rec iat;
	struct speech_rec_notifier recnotifier = {
		on_result,
		on_speech_begin,
		on_speech_end
	};

	if (NULL == audio_file)
		goto iat_exit;

	f_pcm = fopen(audio_file, "rb");
	if (NULL == f_pcm)
	{
		printf("\nopen [%s] failed! \n", audio_file);
		goto iat_exit;
	}

	fseek(f_pcm, 0, SEEK_END);
	pcm_size = ftell(f_pcm);
	fseek(f_pcm, 0, SEEK_SET);

	p_pcm = (char *)malloc(pcm_size);
	if (NULL == p_pcm)
	{
		printf("\nout of memory! \n");
		goto iat_exit;
	}

	read_size = fread((void *)p_pcm, 1, pcm_size, f_pcm);
	if (read_size != pcm_size)
	{
		printf("\nread [%s] error!\n", audio_file);
		goto iat_exit;
	}

	errcode = sr_init(&iat, session_begin_params, SR_USER, &recnotifier);
	if (errcode) {
		printf("speech recognizer init failed : %d\n", errcode);
		goto iat_exit;
	}

	errcode = sr_start_listening(&iat);
	if (errcode) {
		printf("\nsr_start_listening failed! error code:%d\n", errcode);
		goto iat_exit;
	}

	while (1)
	{
		unsigned int len = 10 * FRAME_LEN; /* 200ms audio */
		int ret = 0;

		if (pcm_size < 2 * len)
			len = pcm_size;
		if (len <= 0)
			break;

		ret = sr_write_audio_data(&iat, &p_pcm[pcm_count], len);

		if (0 != ret)
		{
			printf("\nwrite audio data failed! error code:%d\n", ret);
			goto iat_exit;
		}

		pcm_count += (long)len;
		pcm_size -= (long)len;		
	}

	errcode = sr_stop_listening(&iat);
	if (errcode) {
		printf("\nsr_stop_listening failed! error code:%d \n", errcode);
		goto iat_exit;
	}

iat_exit:
	if (NULL != f_pcm)
	{
		fclose(f_pcm);
		f_pcm = NULL;
	}
	if (NULL != p_pcm)
	{
		free(p_pcm);
		p_pcm = NULL;
	}

	sr_stop_listening(&iat);
	sr_uninit(&iat);
}

/* demo recognize the audio from microphone */
static void demo_mic(const char* session_begin_params)
{
	int errcode;
	int i = 0;

	struct speech_rec iat;

	struct speech_rec_notifier recnotifier = {
		on_result,
		on_speech_begin,
		on_speech_end
	};

	errcode = sr_init(&iat, session_begin_params, SR_MIC, &recnotifier);
	if (errcode) {
		printf("speech recognizer init failed\n");
		return;
	}
	errcode = sr_start_listening(&iat);
	if (errcode) {
		printf("start listen failed %d\n", errcode);
	}
	/* demo 8 seconds recording */
	while(i++ < 8)			//这里用来修改录制语音的时间
		sleep(1);
	errcode = sr_stop_listening(&iat);
	if (errcode) {
		printf("stop listening failed %d\n", errcode);
	}

	sr_uninit(&iat);
}

void WakeUp(const std_msgs::String::ConstPtr& msg)		//回调函数中将wakeupFlag置位
{
    printf("waking up\r\n");
    usleep(700*1000);
    wakeupFlag=1;
}
void voiceCmd(const char* g_result)
{ 
    std::string dataString = g_result;
    if(dataString.find("向前") != std::string::npos 
    || dataString.find("前进") != std::string::npos)
    {
         key = "i";
        
        
    }
    else if(dataString.find("向后") != std::string::npos 
    || dataString.find("后退") != std::string::npos)
    {
         key = ",";
        
    }
    else if(dataString.find("左前") != std::string::npos)
    {
         key = "u";
    }
    else if(dataString.find("左后") != std::string::npos)
    {
         key = "m";
    }
    else if(dataString.find("右前") != std::string::npos)
    {
         key = "o";
    }
    else if(dataString.find("右后") != std::string::npos)
    {
         key = ".";
    }
    else if(dataString.find("向左") != std::string::npos 
         || dataString.find("左转") != std::string::npos)
    {
         key = "j";
    }
    else if(dataString.find("向右") != std::string::npos 
         || dataString.find("右转") != std::string::npos)
    {
         key = "l";
    }
    else
    {
         key = "k";
    }
  

}

/* main thread: start/stop record ; query the result of recgonization.
 * record thread: record callback(data write)
 * helper thread: ui(keystroke detection)
 */
int main(int argc, char* argv[])
{
    // 初始化ROS
    ros::init(argc, argv, "voiceRecognition");
    ros::NodeHandle n;
    ros::Rate loop_rate(10);

    // 声明Publisher和Subscriber
    // 订阅唤醒语音识别的信号
    ros::Subscriber wakeUpSub = n.subscribe("voiceWakeup", 1000, WakeUp);   
    // 订阅唤醒语音识别的信号    
    ros::Publisher voiceWordsPub = n.advertise<std_msgs::String>("keyCmd", 1000);  

    ROS_INFO("Sleeping...");
    int count=0;
	//这里会发现删除了一部分询问是否使用用户词库&选择麦克风输入语音等
	//默认使用麦克风

	//随后是进行在线识别的登录
    int ret = MSP_SUCCESS;
    /* login params, please do keep the appid correct */
    const char* login_params = "appid = 594a7b46, work_dir = .";
    int aud_src = 0; /* from mic or file */

    /*
    * See "iFlytek MSC Reference Manual"
    */
    const char* session_begin_params =
        "sub = iat, domain = iat, language = zh_cn, "
        "accent = mandarin, sample_rate = 16000, "
        "result_type = plain, result_encoding = utf8";

    /* Login first. the 1st arg is username, the 2nd arg is password
     * just set them as NULL. the 3rd arg is login paramertes 
     * */
    ret = MSPLogin(NULL, NULL, login_params);
    if (MSP_SUCCESS != ret)	{
        printf("MSPLogin failed , Error code %d.\n",ret);
        goto exit; // login fail, exit the program
    }

	//我们把语音识别的部分加入到循环内，使只要wakeupFlag这个全局变量为1，就进行识别，随后再置零，继续等待语音，一旦唤醒词置位，就识别语音
    while(ros::ok())
    {
        // 语音识别唤醒     
        if(wakeupFlag)
        {
            ROS_INFO("Wakeup...");

	        printf("Demo recognizing the speech from microphone\n");
	        printf("Speak in 8 seconds\n");

	        demo_mic(session_begin_params);

	        printf("8 sec passed\n");
            
            wakeupFlag=0;			//唤醒成功后再把唤醒标志置零，随后跳转到看上面的on_result函数
        }

        // 语音识别完成
        if(resultFlag){				//结果表示符为1时，即执行了show_result函数，就将这个结果g_result以话题形式发布出去
            resultFlag=0;
            std_msgs::String msg;
	    voiceCmd(g_result);
            msg.data = key;
            voiceWordsPub.publish(msg);
        }

        ros::spinOnce();
        loop_rate.sleep();
        count++;
    }
exit:
	MSPLogout(); // Logout...

	return 0;
}


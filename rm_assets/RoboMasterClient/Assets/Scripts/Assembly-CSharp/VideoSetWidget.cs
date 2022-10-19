using UnityEngine;
using UnityEngine.UI;

public class VideoSetWidget : MonoBehaviour
{
	public Image serialPortStatus;
	public Image connectStatus;
	public Text speedRate;
	public Text countryCode;
	public Text aisle;
	public int current_freq;
	public int tx_connect;
	public int current_speed_rate;
	public int current_country_code;
	public Text label_VTM;
	public Text label_VTM_status;
	public Text label_VTM_connect_status;
	public Text label_VTM_speed;
	public Text label_VTM_model;
	public Text label_VTM_channel;
}

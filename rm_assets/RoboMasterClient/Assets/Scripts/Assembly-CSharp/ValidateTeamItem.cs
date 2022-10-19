using UnityEngine;
using UnityEngine.UI;

public class ValidateTeamItem : MonoBehaviour
{
	public TeamType team;
	public Text score_value;
	public Text school_name;
	public Text team_name;
	public Image school_icon;
	public Image win;
	public Image bar;
	public Text base_blood_value;
	public Image base_blood_slid;
	public Text outpost_blood_value;
	public Image outpost_blood_slid;
	public Text guard_blood_value;
	public Image guard_blood_slid;
	public Text total_hurt_value;
	public Image total_hurt_slid;
	public Text rune_value;
	public Image rune_slid;
	public Text kill_value;
	public Image kill_slid;
	public Text total_blood_value;
	public Image total_blood_slid;
	public Transform robot_group;
	public GameObject prefab_robot_item;
}

using UnityEngine;
using UnityEngine.UI;

public class SupplyUIItem : MonoBehaviour
{
	public enum ItemState
	{
		left = 0,
		right = 1,
	}

	public ItemState itemstate;
	public Image robot;
	public Button btntip;
	public Text label;
	public Image bar;
	public Button btn_add50;
	public Button btn_add100;
	public Button btn_add200;
}

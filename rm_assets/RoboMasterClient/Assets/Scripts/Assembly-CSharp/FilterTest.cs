using UnityEngine;

public class FilterTest : MonoBehaviour
{
	private enum DownSampleMode
	{
		Off = 0,
		Half = 1,
		Quarter = 2,
	}

	[SerializeField]
	private Shader _shader;
	[SerializeField]
	private DownSampleMode _downSampleMode;
	[SerializeField]
	private int _iteration;
}

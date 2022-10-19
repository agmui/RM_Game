using UnityEngine;

namespace Klak.Ndi
{
	public class NdiReceiver : MonoBehaviour
	{
		[SerializeField]
		private string _sourceName;
		[SerializeField]
		private RenderTexture _targetTexture;
		[SerializeField]
		private Renderer _targetRenderer;
		[SerializeField]
		private string _targetMaterialProperty;
	}
}

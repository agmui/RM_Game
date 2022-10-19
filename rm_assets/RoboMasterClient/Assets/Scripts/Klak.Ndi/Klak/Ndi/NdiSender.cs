using UnityEngine;

namespace Klak.Ndi
{
	public class NdiSender : MonoBehaviour
	{
		[SerializeField]
		private string _ndiSourceName;
		[SerializeField]
		private string _backUpSourceName;
		[SerializeField]
		private RenderTexture _sourceTexture;
		[SerializeField]
		private bool _alphaSupport;
		public bool senderStop;
	}
}

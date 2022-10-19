using UnityEngine;
using System.Collections.Generic;

namespace UnityEngine.UI
{
	public class UISpriteAnimation : MonoBehaviour
	{
		public float FPS;
		public List<Sprite> SpriteFrames;
		public bool IsPlaying;
		public bool Foward;
		public bool AutoPlay;
		public bool Loop;
		public bool PlayingTwice;
		public bool LoadResource;
		public bool SelfDestroy;
		public string SpriteResourceFolder;
	}
}

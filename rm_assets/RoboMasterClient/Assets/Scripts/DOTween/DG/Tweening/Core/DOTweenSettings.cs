using UnityEngine;
using System;
using DG.Tweening.Core.Enums;
using DG.Tweening;

namespace DG.Tweening.Core
{
	public class DOTweenSettings : ScriptableObject
	{
		[Serializable]
		public class SafeModeOptions
		{
			public NestedTweenFailureBehaviour nestedTweenFailureBehaviour;
		}

		[Serializable]
		public class ModulesSetup
		{
			public bool showPanel;
			public bool audioEnabled;
			public bool physicsEnabled;
			public bool physics2DEnabled;
			public bool spriteEnabled;
			public bool uiEnabled;
			public bool textMeshProEnabled;
			public bool tk2DEnabled;
		}

		public enum SettingsLocation
		{
			AssetsDirectory = 0,
			DOTweenDirectory = 1,
			DemigiantDirectory = 2,
		}

		public bool useSafeMode;
		public SafeModeOptions safeModeOptions;
		public float timeScale;
		public bool useSmoothDeltaTime;
		public float maxSmoothUnscaledTime;
		public RewindCallbackMode rewindCallbackMode;
		public bool showUnityEditorReport;
		public LogBehaviour logBehaviour;
		public bool drawGizmos;
		public bool defaultRecyclable;
		public AutoPlay defaultAutoPlay;
		public UpdateType defaultUpdateType;
		public bool defaultTimeScaleIndependent;
		public Ease defaultEaseType;
		public float defaultEaseOvershootOrAmplitude;
		public float defaultEasePeriod;
		public bool defaultAutoKill;
		public LoopType defaultLoopType;
		public bool debugMode;
		public bool debugStoreTargetId;
		public bool showPreviewPanel;
		public SettingsLocation storeSettingsLocation;
		public ModulesSetup modules;
		public bool showPlayingTweens;
		public bool showPausedTweens;
	}
}

package br.edu.ucb.webdatamodeling.controller
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class AbstractController
	{
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		public function get resourceManager():IResourceManager
		{
			return _resourceManager;
		}

	}
}
package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.Cubo;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.other.pfp.rsscube.models.MainModel;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Alert;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
			
	public class WebDataModelingController
	{
		private var _model:MainModel = MainModel.GetInstance();
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _popup:IFlexDisplayObject;
		
		private var _view:WebDataModeling;
		
		private var _usuarioLogado:Boolean = false;
		
		public function WebDataModelingController(view:WebDataModeling)
		{
			_view = view;
		}
		
		public function get model():MainModel
		{
			return _model;
		}
		 
		public function init():void
		{
			_usuarioService.addEventListener("login", loginHandler);
			if (!_usuarioLogado) {
				_popup = PopUpManager.createPopUp(_view, Cubo , true); 
	            PopUpManager.centerPopUp(_popup);
	            _view.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
   			}
		}
		
		public function verificarUsuarioAutenticado():void
		{
			_usuarioService.verificarUsuarioAutenticado();
			_usuarioService.addEventListener("usuarioLogado", usuarioLogadoHandler);
		}
		
		public function addedToStageHandler(event:Event):void
		{
			_view.stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		public function loginHandler(event:CustomEvent):void
		{
			if (event.data != null) {
				PopUpManager.removePopUp(_popup);
				_view.txtNomeUsuario.text = event.data.nome;
			}
		}
		
		public function usuarioLogadoHandler(event:CustomEvent):void
		{
			if (event.data != null) {
				PopUpManager.removePopUp(_popup);
				_view.txtNomeUsuario.text = event.data.nome;
				_usuarioLogado = true;
			}
		}
		
		public function resizeHandler(event:Event):void
		{
			PopUpManager.centerPopUp(_popup);
		}
		
		public function createTree():void {
			
		}
		
		public function logout():void
		{
			_usuarioService.efetuarLogout();
			//_usuarioService.addEventListener("logout", _view.);
			var v:URLRequest = new URLRequest("C:\\java\\workspaces\\workspaceWDM\\webdatamodeling-client\\bin-debug\\WebDataModeling.swf");
			navigateToURL(v, "_self"); 
		}
		
	}
}
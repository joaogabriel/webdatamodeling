package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.Cubo;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.other.pfp.rsscube.models.MainModel;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import flash.events.Event;
	
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
			
	public class WebDataModelingController
	{
		private var _model:MainModel = MainModel.GetInstance();
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _popup:IFlexDisplayObject;
		
		private var _view:WebDataModeling;
		
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
			_popup = PopUpManager.createPopUp(_view, Cubo , true); 
            PopUpManager.centerPopUp(_popup);
            _view.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
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
		
		public function resizeHandler(event:Event):void
		{
			PopUpManager.centerPopUp(_popup);
		}
		
		public function createTree():void {
			
		}
		
	}
}
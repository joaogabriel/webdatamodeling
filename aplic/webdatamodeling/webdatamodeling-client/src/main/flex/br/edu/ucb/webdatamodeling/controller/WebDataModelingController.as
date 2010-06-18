package br.edu.ucb.webdatamodeling.controller
{
	import br.com.thalespessoa.utils.DisplayUtils;
	import br.edu.ucb.webdatamodeling.components.Cubo;
	import br.edu.ucb.webdatamodeling.display.modeling.StageModeling;
	import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
	import br.edu.ucb.webdatamodeling.dto.MerDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.events.ModelingEvent;
	import br.edu.ucb.webdatamodeling.service.ArquivoService;
	import br.edu.ucb.webdatamodeling.service.MERService;
	import br.edu.ucb.webdatamodeling.service.TipoCampoService;
	import br.edu.ucb.webdatamodeling.service.TipoTabelaService;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	import pfp.rsscube.models.MainModel;
			
	public class WebDataModelingController extends EventDispatcher
	{
		private var _model:MainModel = MainModel.GetInstance();
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _merService:MERService = MERService.getInstance();
		
		private var _arquivoService:ArquivoService = ArquivoService.getInstance();
		
		private var _tipoCampoService:TipoCampoService = TipoCampoService.getInstance();
		
		private var _tipoTabelaService:TipoTabelaService = TipoTabelaService.getInstance();
		
		private var _popup:IFlexDisplayObject;
		
		private var _view:WebDataModeling;
		
		private var _usuarioLogado:Boolean = false;
		
		private var _modeling:StageModeling;
		
		private var _mer:MerDTO;
		
		private var _arquivo:ArquivoDTO;
		
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
			_usuarioService.addEventListener("login", usuarioLogadoHandler);
			_usuarioService.addEventListener("usuarioLogado", usuarioLogadoHandler);
			_usuarioService.verificarUsuarioAutenticado();
			
			_view.content.addEventListener(ManterArquivoController.SHOW_MODELING, showModeling);
		}
		
		private function showModeling(event:CustomEvent):void
		{
			_view.subContent.visible = false;
			
			_arquivo = event.data;
			
			_merService.addEventListener("getByArquivo", modelingHandler);
			_merService.getMerByArquivo(_arquivo);
		}
		
		private function modelingHandler(event:CustomEvent):void
		{
			_mer = event.data;
			
			var ui:UIComponent = new UIComponent();
			_modeling = new StageModeling();
			ui.addChild(_modeling);
			_view.content.addEventListener(Event.RESIZE, contentResizeHandler)
			_modeling.mask = DisplayUtils.drawRect(_view.content.width, _view.content.height, 0);
			ui.addChild(_modeling.mask);
			_view.content.addChild(ui);
			
            _modeling.addEventListener(Event.COMPLETE, modelingCreatedHandler);
            _modeling.addEventListener(ModelingEvent.SAVE, modelingSaveHandler);
            _modeling.addEventListener(ModelingEvent.CLOSE, modelingCloseHandler);
            _modeling.addEventListener(ModelingEvent.GENERATE_SQL, modelingGenerateSQLHandler);
		}
		
		private function modelingCloseHandler(event:ModelingEvent):void
		{
			/*
			_view.subContent.visible = true;
			//_modeling.parent.removeChild(_modeling);
			_modeling.visible = false;
			// remover o ui
			//_view.content.removeChild();
			*/
		}
		
		private function modelingGenerateSQLHandler(event:ModelingEvent):void
		{
			
		}
		
		private function contentResizeHandler(event:Event):void
		{
			var ui:UIComponent = event.target as UIComponent;
			_modeling.mask.width = _view.content.width;
			_modeling.mask.height = _view.content.height;
		}
		
		private function usuarioLogadoHandler(event:CustomEvent):void
		{
			if (event.data == null)
			{
				_popup = PopUpManager.createPopUp(_view, Cubo, true);
	            PopUpManager.centerPopUp(_popup);
	            _view.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
	  		} else {
	  			_view.txtNomeUsuario.text = event.data.nome;
	  			
	  			dispatchEvent(new Event(NovoArquivoController.UPDATE_TREE));
	  			
	  			if (_popup != null) {
	  				PopUpManager.removePopUp(_popup);
	  			}
	  		}
		}
		
		private function modelingSaveHandler(event:ModelingEvent):void
		{
			var tabelas:ArrayCollection = new ArrayCollection(event.tables);
			
			if (_arquivo.mer == null)
			{
				_arquivo.mer = new MerDTO;
				_arquivo.mer.arquivo = _arquivo;
			}
			
			_arquivo.mer.tabelas = tabelas;
			_arquivoService.update(_arquivo);
		}
		
		private function modelingCreatedHandler(event:Event):void
		{
			_tipoCampoService.addEventListener("findAll", tipoCampoHandler);
			_tipoCampoService.findAll();
		}
		
		private function tipoCampoHandler(event:CustomEvent):void
		{
			_modeling.loadFieldTypes(event.data.toArray());
			
			_tipoTabelaService.addEventListener("findAll", tipoTabelaHandler);
			_tipoTabelaService.findAll();
		}
		
		private function tipoTabelaHandler(event:CustomEvent):void
		{
			_modeling.loadTableTypes(event.data.toArray());
			
			if (_mer != null)
			{
				_modeling.openMer(_mer.tabelas.toArray());
			}
		}
		
		public function addedToStageHandler(event:Event):void
		{
			_view.stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		public function loginHandler(event:CustomEvent):void
		{
			if (event.data != null)
			{
				PopUpManager.removePopUp(_popup);
			}
		}
		
		public function resizeHandler(event:Event):void
		{
			PopUpManager.centerPopUp(_popup);
		}
		
		public function logout():void
		{
			_usuarioService.efetuarLogout();
		}
		
	}
}
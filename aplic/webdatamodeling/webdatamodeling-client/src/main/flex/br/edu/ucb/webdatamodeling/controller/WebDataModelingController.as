package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.Cubo;
	import br.edu.ucb.webdatamodeling.display.modeling.StageModeling;
	import br.edu.ucb.webdatamodeling.dto.CampoDTO;
	import br.edu.ucb.webdatamodeling.dto.MerDTO;
	import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
	import br.edu.ucb.webdatamodeling.dto.TipoCampoDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.events.ModelingEvent;
	import br.edu.ucb.webdatamodeling.service.MERService;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import flash.events.Event;
	
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import pfp.rsscube.models.MainModel;
			
	public class WebDataModelingController
	{
		private var _model:MainModel = MainModel.GetInstance();
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _popup:IFlexDisplayObject;
		
		private var _view:WebDataModeling;
		
		private var _usuarioLogado:Boolean = false;
		
		private var _modeling:StageModeling;
		
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
			//_usuarioService.addEventListener("login", loginHandler);
			
			_usuarioService.verificarUsuarioAutenticado();
			_usuarioService.addEventListener("usuarioLogado", usuarioLogadoHandler);
			
				// modelagem
				/*var ui:UIComponent = new UIComponent();
				_modeling = new StageModeling();
				ui.addChild(_modeling);
				_view.content.addChild(ui);
	            _modeling.addEventListener(Event.COMPLETE, modelingCreatedHandler);
	            _modeling.addEventListener(ModelingEvent.SAVE, modelingSaveHandler);*/
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
	  		}
		}
		
		private function modelingSaveHandler(event:ModelingEvent):void
		{
			var service:MERService = new MERService();
			var mer:MerDTO = new MerDTO();
			mer.tabelas = event.tables;
			service.insert(mer)
		}
		
		private function modelingCreatedHandler(event:Event):void
		{
			var table:TabelaDTO = new TabelaDTO();
			var campo:CampoDTO = new CampoDTO();
			var r:Array = [];
			
			table.coordenadaX = 100;
			table.coordenadaY = 100;
			table.descricao = "tab_";
			table.campos = [];
			
			campo.chavePrimaria = true;
			campo.descricao = "id";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "nome";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "idade";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "cidade";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "empresa";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			
			r.push(table);
			
			
			
			table = new TabelaDTO();
			campo = new CampoDTO();
			
			table.coordenadaX = 350;
			table.coordenadaY = 100;
			table.descricao = "tabela 2";
			campo.tipo = new TipoCampoDTO();
			table.campos = [];
			
			campo.chavePrimaria = true;
			campo.descricao = "id_tab2";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "nome";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "campo 5";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			
			
			r.push(table);
			
			
			
			table = new TabelaDTO();
			campo = new CampoDTO();
			
			table.coordenadaX = 350;
			table.coordenadaY = 250;
			table.descricao = "tabela 3";
			campo.tipo = new TipoCampoDTO();
			table.campos = [];
			
			campo.chavePrimaria = true;
			campo.descricao = "id_tab3";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "tab1_id";
			campo.chaveEstrangeira = true;
			campo.tabela = r[0];
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "tab3_id";
			campo.chaveEstrangeira = true;
			campo.tabela = r[1];
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "nome";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "campo3";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			
			
			r.push(table);
			
			
			
			table = new TabelaDTO();
			campo = new CampoDTO();
			
			table.coordenadaX = 530;
			table.coordenadaY = 110;
			table.descricao = "tabela 4";
			table.campos = [];
			
			campo.chavePrimaria = true;
			campo.descricao = "id_tab4";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "tab3_id";
			campo.chaveEstrangeira = true;
			campo.tabela = r[1];
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "nomef";
			campo.tipo = new TipoCampoDTO();
			campo.tipo.descricao = "String";
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "campo2";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			
			
			r.push(table);
			
			
			
			table = new TabelaDTO();
			campo = new CampoDTO();
			
			table.coordenadaX = 330;
			table.coordenadaY = 450;
			table.descricao = "tabela 5";
			table.campos = [];
			
			campo.chavePrimaria = true;
			campo.descricao = "id_tab5";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "tab2_id";
			campo.chaveEstrangeira = true;
			campo.tabela = r[2];
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "nomef sdf";
			campo.tipo = new TipoCampoDTO();
			campo.tipo.descricao = "Varchar";
			table.campos.push(campo);
			
			campo = new CampoDTO();
			campo.descricao = "campo1";
			campo.tipo = new TipoCampoDTO();
			table.campos.push(campo);
			
			
			
			r.push(table);
			 _modeling.openMer(r);
		}
		
		public function addedToStageHandler(event:Event):void
		{
			_view.stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		public function loginHandler(event:CustomEvent):void
		{
			if (event.data != null) {
				PopUpManager.removePopUp(_popup);
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
			//var v:URLRequest = new URLRequest("C:\\java\\workspaces\\workspaceWDM\\webdatamodeling-client\\bin-debug\\WebDataModeling.swf");
			//navigateToURL(v, "_self"); 
		}
		
	}
}
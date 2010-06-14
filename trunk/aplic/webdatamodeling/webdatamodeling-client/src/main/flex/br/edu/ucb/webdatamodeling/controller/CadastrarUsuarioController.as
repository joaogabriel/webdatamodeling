package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.CadastrarUsuario;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import pfp.rsscube.models.MainModel;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.validators.Validator;
			
	public class CadastrarUsuarioController
	{
		[Bindable]
		private var _usuarioDTO:UsuarioDTO = new UsuarioDTO();
		
		private var _model:MainModel = MainModel.GetInstance();
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _view:CadastrarUsuario;
		
		private var timer:Timer;
		
		public var _cont:int = 3;
		
		private var j:uint=10;
		
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		public function CadastrarUsuarioController(view:CadastrarUsuario)
		{
			_view = view;
		}

		public function get model():MainModel
		{
			return _model;
		}
		
		public function limparCampos():void
		{
			_view.txtNome.text = "";
			_view.txtSobrenome.text = "";
			_view.txtEmail.text = "";
			_view.txtSenha.text = "";
			_view.dtfDataNascimento.text = "";
		}
		
		public function novaData():void
		{
			var dataAtual:Date = new Date();
			var formatDate:DateFormatter = new DateFormatter();
			formatDate.formatString = "DD/MM/YYYY";
			_view.txtDataCadastro.text = formatDate.format(dataAtual);
		}
		
		public function validarCadastro():void
		{
			if (Validator.validateAll([_view.valNome, _view.valEmail, _view.valSenha]).length == 0) {
				cadastrar();
			} else {
				Alert.show(_resourceManager.getString('messages', 'usuarioControler.preenchimentoIncorreto'));
			}
		} 
		
		public function cadastrar():void
		{
			_usuarioDTO.nome = _view.txtNome.text;
			_usuarioDTO.sobrenome = _view.txtSobrenome.text;
			_usuarioDTO.email = _view.txtEmail.text;
			_usuarioDTO.senha = _view.txtSenha.text;
			_usuarioDTO.dataNascimento = _view.dtfDataNascimento.selectedDate;
			
			_usuarioService.insert(_usuarioDTO);
			
			posInsert();
		}
		
		private function posInsert():void
		{
			addMensagemSucesso();
			desabiblitarBotoes();
			autenticar();
		}
		
		private function autenticar():void
		{
			_usuarioService.efetuarLogin(_usuarioDTO);
		}

		private function desabiblitarBotoes():void
		{
			_view.btnCadastro.enabled = false;
			_view.btnLimpar.enabled = false;
			_view.btnCancelar.enabled = false;
		}
		
		private function addMensagemSucesso():void
		{
			_view.msgCadastro.visible = true;
		}
		
	}
}
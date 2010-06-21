package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.EditarUsuario;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	import mx.managers.PopUpManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.validators.Validator;
	
	import pfp.rsscube.models.MainModel;
			
	public class EditarUsuarioController
	{
		private var _model:MainModel = MainModel.GetInstance();
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _view:EditarUsuario;
		
		private var _usuarioDTO:UsuarioDTO;
		
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		public function EditarUsuarioController(view:EditarUsuario)
		{
			_view = view;
			
			_usuarioService.addEventListener("usuarioAutenticado", usuarioAutenticadoHandler);
			_usuarioService.getUsuarioAutenticado();
		}

		private function usuarioAutenticadoHandler(event:CustomEvent):void
		{
			_usuarioDTO = event.data;
			
			_view.txtNome.text = _usuarioDTO.nome;
			_view.txtSobrenome.text = _usuarioDTO.sobrenome;
			_view.txtEmail.text = _usuarioDTO.email;
			//_view.txtSenha.text = _usuarioDTO.senha;
			_view.dtfDataNascimento.selectedDate = _usuarioDTO.dataNascimento;
			_view.txtDataCadastro.text = dataToString(_usuarioDTO.dataCadastro);
		}
		
		public function dataToString(data:Date):String
		{
			var formatDate:DateFormatter = new DateFormatter();
			formatDate.formatString = "DD/MM/YYYY";
			return formatDate.format(data);
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
			
			_usuarioService.addEventListener("update", updateHandler);
			_usuarioService.update(_usuarioDTO);
		}
		
		private function updateHandler(event:CustomEvent):void
		{
			_view.msgCadastro.visible = true;
		}
		
		public function fecharPopup():void
		{
			PopUpManager.removePopUp(_view);
		}
		
	}
}
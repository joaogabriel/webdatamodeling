package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.Cadastro;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.other.pfp.rsscube.models.MainModel;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import mx.formatters.DateFormatter;
			
	public class CadastroController
	{
		[Bindable]
		private var _usuarioDTO:UsuarioDTO = new UsuarioDTO();
		
		private var _model:MainModel = MainModel.GetInstance();
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _view:Cadastro;
		
		public function CadastroController(view:Cadastro)
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
		
		public function cadastrar():void
		{
			_usuarioDTO.nome = _view.txtNome.text;
			_usuarioDTO.sobrenome = _view.txtSobrenome.text;
			_usuarioDTO.email = _view.txtEmail.text;
			_usuarioDTO.senha = _view.txtSenha.text;
			_usuarioDTO.dataNascimento = _view.dtfDataNascimento.selectedDate;
			
			_usuarioService.insert(_usuarioDTO);
		}

	}
}
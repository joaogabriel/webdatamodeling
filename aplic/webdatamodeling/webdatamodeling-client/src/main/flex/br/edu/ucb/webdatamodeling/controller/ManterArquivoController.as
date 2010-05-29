package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.CompartilharMER;
	import br.edu.ucb.webdatamodeling.components.ManterArquivo;
	import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.service.ArquivoService;
	
	import br.edu.ucb.webdatamodeling.script.ParseScript;
	
	import flash.events.EventDispatcher;
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	public class ManterArquivoController extends EventDispatcher
	{
		public static const SHOW_MODELING:String = "showModeling";
		
		private var _view:ManterArquivo;
		private var _arquivo:ArquivoDTO;
		private var _arquivoService:ArquivoService = ArquivoService.getInstance();
		
		public function ManterArquivoController(view:ManterArquivo, arquivo:ArquivoDTO)
		{
			_view = view;
			_arquivo = arquivo;
			
			setDadosArquivo();
			setScriptSQL();
		}
		
		private function setScriptSQL():void
		{
			var ps:ParseScript = new ParseScript();
			var script:String = null;
			
			if (_arquivo == null || _arquivo.mer == null || _arquivo.mer.tabelas == null)
			{
				script = "MER ainda não desenhado.";
			}
			
			else
			{
				script = ps.parserScript(_arquivo.mer.tabelas);
			}
			
			_view.txtScript.text = script;
		}
		
		private function setDadosArquivo():void
		{
			_view.nome.text = _arquivo.nome;
			//_view.dtCriacao.text = _arquivo.dataCriacao;
			//_view.dtUltimaAlteracao.text = _arquivo.dataUltimaAlteracao;
			_view.descricao.text = _arquivo.descricao;
			_view.versao.value = _arquivo.versao as Number;
		}
		
		public function salvar():void
		{
			
		}
		
		public function showModelagem():void
		{
           _view.dispatchEvent(new CustomEvent(SHOW_MODELING, _arquivo, true));
		}
		
		public function exportar():void
		{
			Alert.show("Implementar!!!");
			
			var fileReference:FileReference = new FileReference();
			//fileReference.save(listaArquivos.selectedItem.byteArray, listaArquivos.selectedItem.nomeArquivo);
		}
		
		public function compartilhar():void
		{
			var popup:IFlexDisplayObject = PopUpManager.createPopUp(_view, CompartilharMER, true);
			PopUpManager.centerPopUp(popup);
		}
		
		public function excluir():void
		{
			Alert.show("Implementar!!!");
		}
		
		public function gerarScript():void
		{
			Alert.show("pqp!!!");
		}

	}
}
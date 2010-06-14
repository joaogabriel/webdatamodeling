package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.CompartilharMER;
	import br.edu.ucb.webdatamodeling.components.ExportarMER;
	import br.edu.ucb.webdatamodeling.components.ManterArquivo;
	import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.script.ParseScript;
	import br.edu.ucb.webdatamodeling.service.ArquivoService;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.System;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.formatters.DateFormatter;
	import mx.managers.PopUpManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class ManterArquivoController extends EventDispatcher
	{
		public static const SHOW_MODELING:String = "showModeling";
		
		private var _view:ManterArquivo;
		private var _arquivo:ArquivoDTO;
		private var _arquivoService:ArquivoService = ArquivoService.getInstance();
		private var _parser:ParseScript = ParseScript.getInstance();
		private var _script:String;
		
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		public function ManterArquivoController(view:ManterArquivo, arquivo:ArquivoDTO)
		{
			_view = view;
			_arquivo = arquivo;
			
			setDadosArquivo();
			setScriptSQL();
			setImagemExportado();
			setImagemCompartilhado();
			
			if (_arquivo.mer == null)
			{
				_view.btnCompartilhar.enabled = false;
			}
		}
		
		private function setImagemExportado():void
		{
			if (_arquivo.mer != null && _arquivo.mer.exportado)
			{
				_view.imgExportado.source = "assets/images/joia_cima.png";
			}
			else
			{
				_view.imgExportado.source = "assets/images/joia_baixo.png";
			}
		}
		
		private function setImagemCompartilhado():void
		{
			if (_arquivo.mer != null && _arquivo.mer.usuarios != null && _arquivo.mer.usuarios.length > 0)
			{
				_view.imgCompartilhado.source = "assets/images/joia_cima.png";
			}
			else
			{
				_view.imgCompartilhado.source = "assets/images/joia_baixo.png";
			}
		} 
		
		private function setDadosArquivo():void
		{
			_view.txtNome.text = _arquivo.nome;
			_view.dtCriacao.text = formatarData(_arquivo.dataCriacao);
			_view.dtUltimaAlteracao.text = formatarData(_arquivo.dataUltimaAlteracao);
			_view.txtDescricao.text = _arquivo.descricao;
			_view.txtVersao.value = new Number(_arquivo.versao); 
		}
		
		private function setScriptSQL():void
		{
			if (_arquivo == null || _arquivo.mer == null || _arquivo.mer.tabelas == null)
			{
				_script = _resourceManager.getString('messages', 'manterArquivoControler.merNaoDesenhado');
			}
			
			else
			{
				_script = _parser.parserScript(_arquivo.mer);
			}
			
			_view.txtScript.text = _script;
		}
		
		private function formatarData(data:Date):String
		{
			var formatDate:DateFormatter = new DateFormatter();
			formatDate.formatString = "DD/MM/YYYY";
			return formatDate.format(data);
		}
		
		public function salvar():void
		{
			_arquivo.nome = _view.txtNome.text;
			_arquivo.descricao = _view.txtDescricao.text;
			_arquivo.versao = _view.txtVersao.value.toString();
			
			_arquivoService.addEventListener("update", updateHandler);
			_arquivoService.update(_arquivo);
		}
		
		private function updateHandler(event:CustomEvent):void
		{
			_view.msgStatus.text = _resourceManager.getString('messages', 'manterArquivoControler.operacaoComSucesso');
			_view.msgStatus.visible = true;
		}
		
		public function showModelagem():void
		{
           _view.dispatchEvent(new CustomEvent(SHOW_MODELING, _arquivo, true));
		}
		
		public function exportar():void
		{
			var popup:ExportarMER = ExportarMER(PopUpManager.createPopUp(_view, ExportarMER, true));
			popup.arquivo = _arquivo;
			PopUpManager.centerPopUp(popup);
		}
		
		public function compartilhar():void
		{
			var popup:CompartilharMER = CompartilharMER(PopUpManager.createPopUp(_view, CompartilharMER, true));
			popup.mer = _arquivo.mer;
			PopUpManager.centerPopUp(popup);
		}
		
		public function excluir():void
		{
			Alert.show(_resourceManager.getString('messages', 'manterArquivoControler.confirmaExcluirArquivo'), "Aviso", Alert.NO | Alert.YES, null, alertListener);
		}
		
		private function alertListener(event:CloseEvent):void
		{
			if (event.detail == Alert.YES)
			{
			    _arquivoService.addEventListener("remove", excluirHandler);
				_arquivoService.remove(_arquivo);
				
				_view.visible = false;
			}
		}
		
		private function excluirHandler(event:CustomEvent):void
		{
			_view.dispatchEvent(new Event(NovoArquivoController.UPDATE_TREE));
		}
		
		public function gerarScript():void
		{
			Alert.show("pqp!!!");
		}
		
		public function copiarParaAreaDeTransferencia():void
		{
			var scriptFormatted:String = replaceAllString(_script, "\n", "\r\n");
			System.setClipboard(scriptFormatted);
		}
		
		private function replaceAllString(string:String, pattern:String, repl:String):String
		{
			return string.split(pattern).join(repl);
		}

	}
}
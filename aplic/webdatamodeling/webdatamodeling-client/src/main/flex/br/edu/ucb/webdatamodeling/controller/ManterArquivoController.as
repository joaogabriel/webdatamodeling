package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.CompartilharMER;
	import br.edu.ucb.webdatamodeling.components.ExportarMER;
	import br.edu.ucb.webdatamodeling.components.ManterArquivo;
	import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.script.ParseScript;
	import br.edu.ucb.webdatamodeling.service.ArquivoService;
	
	import flash.events.EventDispatcher;
	import flash.system.System;
	
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	import mx.managers.PopUpManager;
	
	public class ManterArquivoController extends EventDispatcher
	{
		public static const SHOW_MODELING:String = "showModeling";
		
		private var _view:ManterArquivo;
		private var _arquivo:ArquivoDTO;
		private var _arquivoService:ArquivoService = ArquivoService.getInstance();
		private var _parser:ParseScript = ParseScript.getInstance();
		private var _script:String;
		
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
			_view.nome.text = _arquivo.nome;
			_view.dtCriacao.text = formatarData(_arquivo.dataCriacao);
			_view.dtUltimaAlteracao.text = formatarData(_arquivo.dataUltimaAlteracao);
			_view.descricao.text = _arquivo.descricao;
			_view.versao.value = _arquivo.versao as Number;
		}
		
		private function setScriptSQL():void
		{
			if (_arquivo == null || _arquivo.mer == null || _arquivo.mer.tabelas == null)
			{
				_script = "MER ainda não desenhado.";
			}
			
			else
			{
				_script = _parser.parserScript(_arquivo.mer.tabelas);
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
			Alert.show("Implementar!!!");
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
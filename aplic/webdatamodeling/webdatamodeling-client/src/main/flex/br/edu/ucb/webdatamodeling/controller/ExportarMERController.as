package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.ExportarMER;
	import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
	import br.edu.ucb.webdatamodeling.dto.TipoArquivoDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.script.ParseScript;
	import br.edu.ucb.webdatamodeling.service.ArquivoService;
	import br.edu.ucb.webdatamodeling.service.TipoArquivoService;
	
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	public class ExportarMERController
	{
		private var _view:ExportarMER;
		private var _arquivo:ArquivoDTO;
		private var _nomeArquivo:String;
		private var _byteArray:ByteArray; 
		
		private var _tipoArquivoService:TipoArquivoService = TipoArquivoService.getInstance();
		private var _arquivoService:ArquivoService = ArquivoService.getInstance();
		
		public function ExportarMERController(view:ExportarMER, arquivo:ArquivoDTO)
		{
			_view = view;
			_arquivo = arquivo;
			
			_view.txtNomeArquivo.text = _arquivo.nome;
			
			_tipoArquivoService.addEventListener("findAll", findAllHandler);
			_tipoArquivoService.findAll();
		}
		
		private function findAllHandler(event:CustomEvent):void
		{
			_view.cbxTipoArquivo.dataProvider = event.data;
		}
		
		public function fecharPopup():void
		{
			PopUpManager.removePopUp(_view);
		}
		
		public function exportar():void
		{
			var scriptParser:ParseScript = ParseScript.getInstance();
			var tipoArquivoSelecionado:TipoArquivoDTO = _view.cbxTipoArquivo.selectedItem as TipoArquivoDTO;
			var tipoArquivo:String = tipoArquivoSelecionado.descricao;
			var script:String = scriptParser.parserScript(_arquivo.mer);
			
			_nomeArquivo = _view.txtNomeArquivo.text + "." + tipoArquivo.toLowerCase(); 
			
			_arquivoService.addEventListener("exportarArquivo", exportarHandler);
			_arquivoService.gerarArquivoParaExportacao(_nomeArquivo, script);
		}
		
		private function exportarHandler(event:CustomEvent):void
		{
			_byteArray = event.data;
			Alert.show("Deseja realizar o download do arquivo?", "Aviso de Segurança", Alert.NO | Alert.YES, _view, alertListener);
			_arquivoService.removeEventListener("exportarArquivo", exportarHandler);
		}
		
		private function updateHandler(event:CustomEvent):void
		{
			fecharPopup();
		}
		
		private function alertListener(event:CloseEvent):void
		{
			if (event.detail == Alert.YES)
			{
				var fileReference:FileReference = new FileReference();
				fileReference.save(_byteArray, _nomeArquivo);
			
				_arquivo.mer.exportado = true;
				_arquivoService.addEventListener("update", updateHandler);
				_arquivoService.update(_arquivo);
			}
			
		}
	}
}
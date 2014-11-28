<?php

require_once TOOLKIT . '/class.datasource.php';

class datasourcetypes_find extends SectionDatasource
{
	public $dsParamROOTELEMENT = 'types-find';
	public $dsParamORDER = 'asc';
	public $dsParamPAGINATERESULTS = 'yes';
	public $dsParamLIMIT = '{$url-pagesize:99}';
	public $dsParamSTARTPAGE = '{$url-pagenum:1}';
	public $dsParamREDIRECTONEMPTY = 'no';
	public $dsParamREDIRECTONFORBIDDEN = 'no';
	public $dsParamREDIRECTONREQUIRED = 'no';
	public $dsParamSORT = 'order';
	public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

	public $dsParamFILTERS = array(
		'system:id' => '{$ds-keywords-find.type:$types}',
		'29' => 'yes',
	);

	public $dsParamINCLUDEDELEMENTS = array(
		'system:pagination',
		'name',
		'attributes'
	);

	public function __construct($env = null, $process_params = true)
	{
		parent::__construct($env, $process_params);
		$this->_dependencies = array('$ds-keywords-find.type');
	}

	public function about()
	{
		return array(
			'name' => 'Types Find',
			'author' => array(
				'name' => 'Pablo Canillas',
				'website' => 'http://folio.localhost',
				'email' => 'noreply@localhost.tld'),
			'version' => 'Symphony 2.5.1',
			'release-date' => '2014-11-27T10:25:26+00:00'
		);
	}

	public function getSource()
	{
		return '7';
	}

	public function allowEditorToParse()
	{
		return true;
	}

	public function execute(array &$param_pool = null)
	{
		$result = new XMLElement($this->dsParamROOTELEMENT);

		try{
			$result = parent::execute($param_pool);
		} catch (FrontendPageNotFoundException $e) {
			// Work around. This ensures the 404 page is displayed and
			// is not picked up by the default catch() statement below
			FrontendPageNotFoundExceptionHandler::render($e);
		} catch (Exception $e) {
			$result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
			return $result;
		}

		if ($this->_force_empty_result) {
			$result = $this->emptyXMLSet();
		}

		if ($this->_negate_result) {
			$result = $this->negateXMLSet();
		}

		return $result;
	}
}
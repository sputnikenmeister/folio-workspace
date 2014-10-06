<?php

require_once TOOLKIT . '/class.datasource.php';

class datasourcetypes_by_id extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'types-by-id';
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
        'system:id' => '{$types:$ds-keywords-by-id.type}',
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
        $this->_dependencies = array('$ds-keywords-by-id.type');
    }

    public function about()
    {
        return array(
            'name' => 'Types by ID',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://fulanito.localhost',
                'email' => 'noreply@localhost.tld'),
            'version' => 'Symphony 2.5.0',
            'release-date' => '2014-09-28T10:34:21+00:00'
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
<?php

class datasourcemedia_find_by_bundle extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'media-find-by-bundle';
    public $dsParamORDER = 'asc';
    public $dsParamGROUP = '51';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'order';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '26' => 'yes',
        '51' => '{$ds-bundles-get.system-id:$ds-bundles-find.system-id:0}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'file',
        'bundle',
        'description: formatted',
        'attributes',
        'order'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-bundles-get.system-id', '$ds-bundles-find.system-id');
    }

    public function about()
    {
        return array(
            'name' => 'Media Find by Bundle',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://krupp.local/projects/folio-sym',
                'email' => 'noreply@localhost.tld'),
            'version' => 'Symphony 2.6.2',
            'release-date' => '2015-07-04T11:18:25+00:00'
        );
    }

    public function getSource()
    {
        return '5';
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
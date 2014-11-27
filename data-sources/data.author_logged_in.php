<?php

require_once TOOLKIT . '/class.datasource.php';

class datasourceauthor_logged_in extends AuthorDatasource
{
    public $dsParamROOTELEMENT = 'author-logged-in';
    public $dsParamORDER = 'desc';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'id';

    public $dsParamFILTERS = array(
        'username' => '{$cookie-username:0}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'username'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Author Logged In',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://folio.localhost',
                'email' => 'noreply@localhost.tld'),
            'version' => 'Symphony 2.5.1',
            'release-date' => '2014-11-27T10:44:42+00:00'
        );
    }

    public function getSource()
    {
        return 'authors';
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
<?php

require_once TOOLKIT . '/class.event.php';

class eventadministrator_only extends SectionEvent
{
    public $ROOTELEMENT = 'administrator-only';

    public $eParamFILTERS = array(
        'admin-only'
    );

    public static function about()
    {
        return array(
            'name' => 'Administrator Only',
            'author' => array(
                'name' => 'Pablo Canillas',
                'website' => 'http://fulanito.localhost',
                'email' => 'nobody@localhost'),
            'version' => 'Symphony 2.5.0',
            'release-date' => '2014-09-27T12:06:56+00:00',
            'trigger-condition' => 'action[administrator-only]'
        );
    }

    public static function getSource()
    {
        return '1';
    }

    public static function allowEditorToParse()
    {
        return true;
    }

    public static function documentation()
    {
        return '
                <h3>Success and Failure XML Examples</h3>
                <p>When saved successfully, the following XML will be returned:</p>
                <pre class="XML"><code>&lt;administrator-only result="success" type="create | edit">
    &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/administrator-only></code></pre>
                <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned:</p>
                <pre class="XML"><code>&lt;administrator-only result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;field-name type="invalid | missing" />
...&lt;/administrator-only></code></pre>
                <p>The following is an example of what is returned if any options return an error:</p>
                <pre class="XML"><code>&lt;administrator-only result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;filter name="admin-only" status="failed" />
    &lt;filter name="send-email" status="failed">Recipient not found&lt;/filter>
...&lt;/administrator-only></code></pre>
                <h3>Example Front-end Form Markup</h3>
                <p>This is an example of the form markup you can use on your frontend:</p>
                <pre class="XML"><code>&lt;form method="post" action="{$current-url}/" enctype="multipart/form-data">
    &lt;input name="MAX_FILE_SIZE" type="hidden" value="5242880" />
    &lt;label>Name
        &lt;input name="fields[name]" type="text" />
    &lt;/label>
    &lt;label>Display Name
        &lt;textarea name="fields[display-name]" rows="1" cols="50">&lt;/textarea>
    &lt;/label>
    &lt;label>Published
        &lt;input name="fields[published]" type="checkbox" value="yes" />
    &lt;/label>
    &lt;label>Completed
        &lt;input name="fields[completed]" type="text" />
    &lt;/label>
    &lt;label>Description
        &lt;textarea name="fields[description]" rows="12" cols="50">&lt;/textarea>
    &lt;/label>
    &lt;label>Attributes
        &lt;input name="fields[attributes]" type="text" />
    &lt;/label>
    &lt;input name="fields[images]" type="hidden" value="…" />
    &lt;input name="fields[keywords]" type="hidden" value="…" />
    &lt;input name="fields[keywords2]" type="hidden" value="..." />
    &lt;input name="action[administrator-only]" type="submit" value="Submit" />
&lt;/form></code></pre>
                <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
                <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
                <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
                <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://fulanito.localhost/success/" /></code></pre>';
    }

    public function load()
    {
        if (isset($_POST['action']['administrator-only'])) {
            return $this->__trigger();
        }
    }

}

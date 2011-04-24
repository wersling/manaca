package net.manaca.application.config
{
import flash.system.Security;

import net.manaca.application.config.model.SecuritySettingsInfo;
import net.manaca.application.thread.AbstractProcess;
import net.manaca.errors.IllegalArgumentError;

/**
 * The LoggingConfiguration provide a security initialize by config file.
 * @author v-seanzo
 *
 */
public class SecuritySettingsConfiguration extends AbstractProcess
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var info:SecuritySettingsInfo;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>SecuritySettingsConfiguration</code> instance.
     * @param info the security info.
     *
     */
    public function SecuritySettingsConfiguration(info:SecuritySettingsInfo)
    {
        super();

        if(info != null)
        {
            this.info = info;
        }
        else
        {
            throw new IllegalArgumentError("invalid info argument:" + info);
        }
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * Start initialize the PolicyFile and allowedDomains.
     * <ul>
     *     <li>
     *         load Policy Files.
     *     </li>
     *     <li>
     *         set the allow doamins.
     *     </li>
     * </ul>
     */
    override protected function run():void
    {
        // configure cross domains
        if(info.CrossDomainPolicies && info.CrossDomainPolicies.url)
        {
            var urlList:Array = info.CrossDomainPolicies.urlList;
            var urlListLength:uint = urlList.length;
            for(var i:uint = 0; i < urlListLength; i++)
            {
                Security.loadPolicyFile(urlList[i]);
            }
        }

        // configure allowed domains
        if(info.AllowedDomains && info.AllowedDomains.domain)
        {
            var domainList:Array = info.AllowedDomains.domainList;
            var domainListLength:uint = domainList.length;
            for(var j:uint = 0; j < domainListLength; j++)
            {
                Security.allowDomain(domainList[j]);
            }
        }
        this.finish();
    }
}
}
/*
 * Copyright (c) 2011, 9nali.com All rights reserved.
 */
package org.swiftsuspenders.injectionresults
{
	import org.swiftsuspenders.Injector;

	public class InjectClassResult extends InjectionResult
	{
		/*******************************************************************************************
		 *								private properties										   *
		 *******************************************************************************************/
		private var m_responseType : Class;
		
		
		/*******************************************************************************************
		 *								public methods											   *
		 *******************************************************************************************/
		public function InjectClassResult(responseType : Class)
		{
			m_responseType = responseType;
		}
		
		override public function getResponse(injector : Injector) : Object
		{
			return injector.instantiate(m_responseType);
		}
	}
}

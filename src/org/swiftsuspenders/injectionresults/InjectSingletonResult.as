/*
 * Copyright (c) 2011, 9nali.com All rights reserved.
 */
package org.swiftsuspenders.injectionresults
{
	import org.swiftsuspenders.Injector;

	public class InjectSingletonResult extends InjectionResult
	{
		/*******************************************************************************************
		 *								private properties										   *
		 *******************************************************************************************/
		private var m_responseType : Class;
		private var m_response : Object;
		
		
		/*******************************************************************************************
		 *								public methods											   *
		 *******************************************************************************************/
		public function InjectSingletonResult(responseType : Class)
		{
			m_responseType = responseType;
		}
		
		override public function getResponse(injector : Injector) : Object
		{
			return m_response ||= createResponse(injector);
		}
		
		
		/*******************************************************************************************
		 *								private methods											   *
		 *******************************************************************************************/
		private function createResponse(injector : Injector) : Object
		{
			return injector.instantiate(m_responseType);
		}
	}
}

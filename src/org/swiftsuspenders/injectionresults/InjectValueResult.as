/*
 * Copyright (c) 2011, 9nali.com All rights reserved.
 */
package org.swiftsuspenders.injectionresults
{
	import org.swiftsuspenders.Injector;
	
	public class InjectValueResult extends InjectionResult
	{
		/*******************************************************************************************
		 *								private properties										   *
		 *******************************************************************************************/
		private var m_value : Object;
		
		
		/*******************************************************************************************
		 *								public methods											   *
		 *******************************************************************************************/
		public function InjectValueResult(value : Object)
		{
			m_value = value;
		}
		
		override public function getResponse(injector : Injector) : Object
		{
			return m_value;
		}
	}
}

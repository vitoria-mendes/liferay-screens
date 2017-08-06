/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 * <p>
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 * <p>
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package com.liferay.mobile.screens.portlet.view;

import android.view.View;
import android.webkit.WebView;
import com.liferay.mobile.screens.base.view.BaseViewModel;
import com.liferay.mobile.screens.portlet.util.InjectableScript;
import com.liferay.mobile.screens.viewsets.defaultviews.portlet.cordova.CordovaLifeCycleObserver;

/**
 * @author Sarai Díaz García
 */
public interface PortletDisplayViewModel extends BaseViewModel {

	/**
	 * Called when portlet screenlet is ready to be displayed.
	 *
	 * @param url portlet url.
	 * @param injectedJs custom Javascript to use in the portlet.
	 */
	void postUrl(String url, String body);

	/**
	 * Called when portlet screenlet is ready to be displayed.
	 *
	 * @param url portlet url.
	 * @param injectedJs custom Javascript to use in the portlet.
	 */
	void loadUrl(String url);

	/**
	 * Called this method to inject generated javascript in portlet {@link WebView}.
	 *
	 * @param js generated javascript from {@link JavascriptInjector}.
	 */
	void injectScript(InjectableScript script);

	void addScript(InjectableScript script);

	/**
	 * Called this method to set the automatic mode to inject the css and js files
	 * from visible portlets automatically if exists.
	 *
	 * @param theme if the proper css and js files must be injected or not.
	 */
	void setTheme(boolean theme);


	void configureView(boolean isCordovaEnabled, CordovaLifeCycleObserver observer);
}

/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/
import UIKit


@objc public protocol CommentDisplayScreenletDelegate : BaseScreenletDelegate {

	optional func screenlet(screenlet: CommentDisplayScreenlet,
	                        onCommentLoaded comment: Comment)

	optional func screenlet(screenlet: CommentDisplayScreenlet,
	                        onLoadCommentError error: NSError)

}


@IBDesignable public class CommentDisplayScreenlet: BaseScreenlet {

	@IBInspectable public var groupId: Int64 = 0

	@IBInspectable public var commentId: Int64 = 0

	@IBInspectable public var autoLoad: Bool = true

	public var commentDisplayDelegate: CommentDisplayScreenletDelegate? {
		return delegate as? CommentDisplayScreenletDelegate
	}

	public var viewModel: CommentDisplayViewModel? {
		return screenletView as? CommentDisplayViewModel
	}

	//MARK: Public methods

	override public func onShow() {
		if !isRunningOnInterfaceBuilder {
			if autoLoad {
				load()
			}
		}
	}

	public func load() {
		performDefaultAction()
	}

	//MARK: BaseScreenlet

	override public func createInteractor(name name: String, sender: AnyObject?) -> Interactor? {
		let interactor = CommentLoadInteractor(
			screenlet: self,
			groupId: self.groupId,
			commentId: self.commentId)

		interactor.onSuccess = {
			if let resultComment = interactor.resultComment {
				self.commentDisplayDelegate?.screenlet?(self, onCommentLoaded: resultComment)
				self.viewModel?.comment = resultComment
			}
			else {
				self.commentDisplayDelegate?.screenlet?(self,
					onLoadCommentError: NSError.errorWithCause(.InvalidServerResponse))
			}
		}

		interactor.onFailure = {
			self.commentDisplayDelegate?.screenlet?(self, onLoadCommentError: $0)
		}
		
		return interactor
	}
	
}

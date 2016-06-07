###
# Copyright (C) 2014-2015 Taiga Agile LLC <taiga@taiga.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: wiki-history.controller.spec.coffee
###

describe "WikiHistorySection", ->
    provide = null
    controller = null
    mocks = {}

    _mockTgResources = () ->
        mocks.tgResources = {
            wikiHistory: {
                getWikiHistory: sinon.stub()
            }
        }

        provide.value "tgResources", mocks.tgResources

    _mocks = () ->
        module ($provide) ->
            provide = $provide
            _mockTgResources()
            return null

    beforeEach ->
        module "taigaWikiHistory"

        _mocks()


        inject ($controller) ->
            controller = $controller
        promise = mocks.tgResources.wikiHistory.getWikiHistory.promise().resolve()

    it "load wiki historic", (done) ->
        historyCtrl = controller "WikiHistoryCtrl"

        historyCtrl._getActivity = sinon.stub()

        wikiID = 45
        promise = mocks.tgResources.wikiHistory.getWikiHistory.withArgs(wikiID).promise().resolve()

        historyCtrl._loadHistory().then (activities) ->
            expect(historyCtrl._getActivity).have.been.calledWithExactly(activities)
            done()

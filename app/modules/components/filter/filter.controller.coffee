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
# File: filter.controller.coffee
###

class FilterController
    @.$inject = []

    constructor: () ->
        @.opened = null
        @.filtersSelected = []
        @.customFilterForm = false
        @.customFilterName = ''

    toggleFilterCategory: (filterName) ->
        if @.opened == filterName
            @.opened = null
        else
            @.opened = filterName

    isOpen: (filterName) ->
        return @.opened == filterName

    saveCustomFilter: () ->
        @.onSaveCustomFilter({name: @.customFilterName, filters: @.filtersSelected})

    unselectFilter: (appliedFilter) ->
        _.remove @.filtersSelected, (it) ->
            return appliedFilter.category.dataType == it.category.dataType &&
              appliedFilter.filter.name == it.filter.name

        @.onChangeFilter({filters: @.filtersSelected})

    selectFilter: (filterCategory, filter) ->
        @.filtersSelected.push({
            category: filterCategory
            filter: filter
        })

        @.onChangeFilter({filters: @.filtersSelected})

    isFilterSelected: (filterCategory, filter) ->
        return  !!_.find @.filtersSelected, (it) ->
            return filterCategory.dataType == it.category.dataType && filter.name == it.filter.name

angular.module('taigaComponents').controller('Filter', FilterController)

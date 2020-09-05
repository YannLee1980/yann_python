from django import forms

class ShortSearchForm(forms.Form):
    short = forms.CharField(empty_value='search', label='')

class DateSearchForm(forms.Form):
    date = forms.DateField(required=False, label='')
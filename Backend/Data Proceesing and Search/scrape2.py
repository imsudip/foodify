from turtle import title
from bs4 import BeautifulSoup
import requests
import re
import pandas as pd
import json
import unicodedata
from n import replace_fractions


def getText(element, tag, class_, text='ele'):
    try:
        return element.find(tag, class_=class_).text
    except:
        print("No " + text + " found")
        return ''


def get_recipe_data(url, api_key):

    # url = 'https://myfoodstory.com/american-chopsuey/'
    recipe = {}
    recipe['url'] = url.strip()
    page = requests.get(
        "https://api.scrapingdog.com/scrape?api_key="+api_key+"&url="+url+"&dynamic=false")
    soup = BeautifulSoup(page.content, 'html.parser')
    clsName = 'wprm-recipe-print-inline-button'
    a_tags = soup.find_all('a', class_=clsName)
    nLink = ""
    if len(a_tags) > 0:
        nLink = a_tags[0]['href']
    else:
        print("No print link found")
        return None

    clsName = 'entry-content'
    ft = soup.find('div', class_=clsName)
    imgs = ft.find_all('img')
    if len(imgs) > 0:
        img = imgs[0]
        print(img)
        img_src = img['srcset'].split(',')[0]
        recipe['image'] = img_src
    else:
        print("No image found")
        return None
    try:
        iframe = soup.find('iframe')
        iframe_src = iframe['data-l-src']
        video_id = iframe_src.split('/')[-1]
        video_id = video_id.split('?')[0]
        recipe['video_id'] = video_id
    except:
        print('No video')
        recipe['video_id'] = ''
    recipe['p_id'] = nLink.split('/')[-1]
    # print page
    page = requests.get(
        "https://api.scrapingdog.com/scrape?api_key="+api_key+"&url="+nLink+"&dynamic=false")
    soup = BeautifulSoup(page.content, 'html.parser')
    # get the title
    recipe['title'] = getText(soup, 'h2', 'wprm-recipe-name', 'title')
    # get the description
    recipe['description'] = getText(
        soup, 'div', 'wprm-recipe-summary', 'description')
    # get the course
    recipe['course'] = getText(
        soup, 'span', 'wprm-recipe-course wprm-block-text-normal', 'course')
    # get the servings
    recipe['servings'] = getText(
        soup, 'span', 'wprm-recipe-servings-with-unit', 'servings')
    # split the servings string by the word 'servings'
    recipe['servings'] = recipe['servings'].split(' ')[0]
    # get the Cuiisine
    recipe['cuisine'] = getText(
        soup, 'span', 'wprm-recipe-cuisine wprm-block-text-normal', 'cuisine')
    # get the Diet
    recipe['diet'] = getText(
        soup, 'span', 'wprm-recipe-suitablefordiet wprm-block-text-normal', 'diet')
    # get the div having one of the class contains 'wprm-recipe-total-time-container'
    div = soup.find('div', class_='wprm-recipe-total-time-container')
    # get the time
    recipe['time'] = getText(
        div, 'span', 'wprm-recipe-time wprm-block-text-normal', 'time')
    # get the calories
    recipe['calories'] = getText(
        soup, 'span', 'wprm-recipe-nutrition-with-unit', 'calories')
    recipe['calories'] = recipe['calories'].split('k')[0]
    # get the author
    recipe['author'] = getText(
        soup, 'span', 'wprm-recipe-details wprm-recipe-author wprm-block-text-normal', 'author')
    # get the ingredients
    box = soup.find('div', class_='wprm-recipe-ingredients-container')
    # get all 'wprm-recipe-ingredient-group' tags
    ing_grp = box.find_all('div', class_='wprm-recipe-ingredient-group')
    l = []
    for item in ing_grp:
        s = {}
        # title = item.find('h4').text if item.find('h4') else ''
        title = getText(item, 'h4', 'wprm-recipe-group-name', 'ing title')
        if title != '':
            title = "@@T@@"+title
            l.append(title)
        lTag = item.find_all('li', class_='wprm-recipe-ingredient')
        for li in lTag:
            amount = li.find('span', class_='wprm-recipe-ingredient-amount')
            unit = li.find('span', class_='wprm-recipe-ingredient-unit')
            name = li.find('span', class_='wprm-recipe-ingredient-name')
            note = li.find('span', class_='wprm-recipe-ingredient-notes')
            if amount:
                amount = amount.text
                amount = replace_fractions(amount)
            obj = (amount if amount is not None else "")+"," + \
                (unit.text if unit is not None else "") + \
                ","+(name.text if name is not None else "") + \
                ","+(note.text if note is not None else "")
            l.append(obj)
    recipe['ingredients'] = l
    # get the instructions
    box = soup.find(
        'div', class_='wprm-recipe-instructions-container')
    # get all 'wprm-recipe-instruction-group' tags
    instr_grp = box.find_all('div', class_='wprm-recipe-instruction-group')
    l = []
    for item in instr_grp:
        title = getText(item, 'h4', 'wprm-recipe-group-name', 'instr title')
        if title != '':
            title = "@@T@@"+title
            l.append(title)
        lTag = item.find_all('li', class_='wprm-recipe-instruction')
        for li in lTag:
            l.append(li.text if li is not None else "")
    recipe['instructions'] = l
    # get the nutrition
    box = soup.find(
        'div', class_='wprm-nutrition-label-container')
    # get all 'wprm-nutrition-label-text-nutrition-container' tags
    nutr_grp = box.find_all(
        'span', class_='wprm-nutrition-label-text-nutrition-container')
    l = []
    for item in nutr_grp:
        s = ''
        s = getText(item, 'span', 'wprm-nutrition-label-text-nutrition-label')+","+getText(item, 'span',
                                                                                           'wprm-nutrition-label-text-nutrition-value')+","+getText(item, 'span', 'wprm-nutrition-label-text-nutrition-unit')
        l.append(s)
    recipe['nutrition'] = l
    print('done')
    return recipe
    # # convert to json and save to file
    # with open('recipe.json', 'w') as f:
    #     json.dump(recipe, f, indent=4)

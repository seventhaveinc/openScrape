# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'Mechanize'
require 'awesome_print'
require 'net/http'
require 'http'
require 'JSON'
require 'uri'




correct_hrefs = []
counter=0
    
# HollywoodUnlocked
    agent = Mechanize.new
    url = "https://hollywoodunlocked.com/category/news/"
    page = agent.get(url) 
    site = page.search('.article-contain')
    site.each do |k|
        links = k.search('a').attr('href')
        # ap links 
        correct_hrefs.push(links)
    end
    ap correct_hrefs.count
    pp "Current Site : HollywoodUnlocked"


# Essence
    agent = Mechanize.new
    url = "https://www.essence.com/news/"
    page = agent.get(url)
    site = page.search('article')
    site.each do |b|
        links = b.search('a').attr('href').value
        # pp links
        correct_hrefs.push(links)
    end
    ap correct_hrefs.count
    pp "Current Site : Essence"





# BallerAlert [X]
    agent = Mechanize.new
    url="https://balleralert.com/"
    page=agent.get(url)
    page.search('.item-list').each do |sauce|
        title= sauce.search('.post-box-title').search('a')
        link = title.attr("href").value
        correct_hrefs.push(link)
    end
    ap correct_hrefs.count 
    p "Current Site : Baller Alert "


#PeopleOfColorInTech [X]
    agent = Mechanize.new
    range =(1...39)

    range.each do |adder|
    site = "https://peopleofcolorintech.com/category/articles/page/" + adder.to_s + "/"
    page = agent.get(site)
    bcontainer = page.search('.content-header-single')
        bcontainer.each do |xp|
            smdata = xp.search('.content-title').search('a').attr('href').value
            correct_hrefs.push(smdata)
        end
    end
    ap correct_hrefs.count 
    p "Current Site : People Of Color In Tech "


# AfroTech[X]
    agent = Mechanize.new
    url="https://afrotech.com/news"
    page=agent.get(url)
    info= page.search('.article-card')
    info.each do |u|
        link = u.search('a').attr('href').value
        full_site = url + link
        correct_hrefs.push(full_site)
        # ap full_site
    end
    ap correct_hrefs.count 
    p "Current Site : Afro Tech "



    # RevoltTv[X]
    agent=Mechanize.new
    range = (2...5)
    counter = 0
    range.each do |p|
        url = "https://www.revolt.tv/revolt-black-news/archives/" + p.to_s
        page = agent.get(url)

        data_pool = page.search('.c-compact-river__entry')

        data_pool.each do |t|
            links = t.search('a').attr('href')
            correct_hrefs.push(links.value)
        end
    end
    ap correct_hrefs.count 
    p "Current Site : Revolt TV"



#BlavityOne [X]{wp.}

    uri = URI.parse("https://api1.blavity.com/v1/articles/tags/blavity-original,Blavity-Original/8/0")
    request = Net::HTTP::Get.new(uri)
    request["Sec-Ch-Ua"] = "\"Chromium\";v=\"92\", \" Not A;Brand\";v=\"99\", \"Google Chrome\";v=\"92\""
    request["Accept"] = "application/json, text/plain, */*"
    request["Referer"] = "https://blavity.com/"
    request["Sec-Ch-Ua-Mobile"] = "?0"
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36"

    req_options = {
    use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
    end

    site = response.body
    noko = Nokogiri::HTML(site)
    link = noko.search('a')
    link.each do |tag|
        data= tag.attr('href')
        if(data.include?("blavity")== true && data.length > 50)
        fixedStr =  data.slice!(2..-3)
        #    ap fixedStr
        correct_hrefs.push(fixedStr)
        end
    end
    ap correct_hrefs.count 
    p "Current Site : Blavity"

    
# Hip Hop DX  [X]
    agent = Mechanize.new
    url = "https://hiphopdx.com/"
    page = agent.get(url)
    bigData = page.search('.news-info')
    bigData.each do |info|
        # title = info.text.split("\n")[8]
        link = info.search('a').attr('href').value
        # ap link
        correct_hrefs.push(link)
    end
    ap correct_hrefs.count 
    p "Current Site : HipHopDx"


    p "...wait 90 seconds "

#LoveBScott
    pagesTho = (1..2427)
    holder = []

    while (counter < 2427) do
        url = 'https://www.lovebscott.com/category/news/page/' + counter.to_s
        # p url
        agent = Mechanize.new
        page = agent.get(url)
        box = page.search('.sf-entry-title')
            box.each do |crate|
                envelope = crate.search('a').attr('href').value
                # ap envelope
                holder.push(envelope)
                counter += 1
            end 
            neatPosts =  holder
            correct_hrefs.push(neatPosts)
    end

correct_hrefs.each do |g|
    Link.create(
        url: g
    )
end
    # ap correct_hrefs.uniq

    # HTTP.post('localhost:2000', :json => {data:correct_hrefs})    


module Yer
    class Iscrape < ApplicationController
        def self.initialize
        require 'Mechanize'
        require 'awesome_print'
        require 'net/http'
        require 'http'
        require 'json'
        require 'uri'
        
        finalContainer = []
        correct_hrefs = []
        counter=0

# Need to add 
# shadowandact
# uri = URI.parse("https://api1+.blavity.com/v1/trending_articles")
# request = Net::HTTP::Get.new(uri)
# request["Sec-Ch-Ua"] = "\"Chromium\";v=\"92\", \" Not A;Brand\";v=\"99\", \"Google Chrome\";v=\"92\""
# request["Accept"] = "application/json, text/plain, */*"
# request["Referer"] = "https://shadowandact.com/"
# request["Sec-Ch-Ua-Mobile"] = "?0"
# request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36"

# req_options = {
#     use_ssl: uri.scheme == "https",
# }

# response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
#     http.request(request)
# end

# # response.code
# site = response.body
# json = JSON.parse(site)
# json.each do |i|
#     fdata = "https://shadowandact.com/"+ i["slug"]
#     correct_hrefs.push(fdata)
#     ap fdata
# end

# BleacherReport 

url="https://bleacherreport.com/nba"
agent= Mechanize.new
page = agent.get(url)
cell = page.search('.contentStream').search('li').search('a')
cell.each do |u|
    link = u.attr('href')
    slink = link.to_s
    if(slink.length > 70)
        correct_hrefs.push(slink)
    end
end
ap correct_hrefs.count
ap 'Current Site : BleacherReport'




# complex
url = "https://www.complex.com/pop-culture/"
agent = Mechanize.new
page = agent.get(url)
data = page.search('.main-container').search('a')
data.each do |e|
    link = e.attr('href').to_s
    if(link.length > 30)
        correct_hrefs.push("https://www.complex.com"+ link)
        # ap link
    end
end
ap correct_hrefs.count
ap 'Current Site : Complex'


# HollywoodUnlocked
    # agent = Mechanize.new
    # url = "https://hollywoodunlocked.com/category/news/"
    # page = agent.get(url) 
    # site = page.search('.article-contain')
    # site.each do |k|
    #     links = k.search('a').attr('href')
    #     correct_hrefs.push(links)
    # end
    # ap correct_hrefs.count
    # pp "Current Site : HollywoodUnlocked"


# Essence
    agent = Mechanize.new
    url = "https://www.essence.com/news/"
    page = agent.get(url)
    site = page.search('article')
    site.each do |b|
        links = b.search('a').attr('href').value
        correct_hrefs.push(links)
    end
    ap correct_hrefs.count
    pp "Current Site : Essence"





# # BallerAlert [X]
#     agent = Mechanize.new
#     url="https://balleralert.com/"
#     page=agent.get(url)
#     page.search('.item-list').each do |sauce|
#         title= sauce.search('.post-box-title').search('a')
#         link = title.attr("href").value
#         correct_hrefs.push(link)
#     end
#     ap correct_hrefs.count 
#     p "Current Site : Baller Alert "


# #PeopleOfColorInTech [X]
#     agent = Mechanize.new
#     range =(1...39)

#     range.each do |adder|
#     site = "https://peopleofcolorintech.com/category/articles/page/" + adder.to_s + "/"
#     page = agent.get(site)
#     bcontainer = page.search('.content-header-single')
#         bcontainer.each do |xp|
#             smdata = xp.search('.content-title').search('a').attr('href').value
#             correct_hrefs.push(smdata)
#         end
#     end
#     ap correct_hrefs.count 
#     p "Current Site : People Of Color In Tech "


# AfroTech[X]
    agent = Mechanize.new
    url="https://afrotech.com"
    page=agent.get(url)
    info= page.search('.article-card__title')
    info.each do |u|
        link = u.search('a').attr('href').value
        full_site = url + link
        correct_hrefs.push(full_site)
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
        link = info.search('a').attr('href').value
        correct_hrefs.push(link)
    end
    ap correct_hrefs.count 
    p "Current Site : HipHopDx"
    p "...wait 130 seconds "

#LoveBScott
    # pagesTho = (1..2427)
    # holder = []

    # while (counter < 2427) do
    #     url = 'https://www.lovebscott.com/category/news/page/' + counter.to_s
    #     # p url
    #     agent = Mechanize.new
    #     page = agent.get(url)
    #     box = page.search('.sf-entry-title')
    #         box.each do |crate|
    #             envelope = crate.search('a').attr('href').value
    #             # ap envelope
    #             holder.push(envelope)
    #             counter += 1
    #         end 
    #         neatPosts =  holder
    #         correct_hrefs.push(neatPosts)
    # end
    #             correct_hrefs.each do |p|
    #                 if(p.to_s.length > 5) 
    #                     finalContainer.push(p.to_s)
    #                 end
    #             end

            # if finalContainer.length < 1
            #     return {status: 400}
            # else
            #     return {data: finalContainer,status:200}
            # end
            return {data: correct_hrefs ,status:200}
    #  return correct_hrefs.uniq.to_json
    # HTTP.post('localhost:3000/links', :json => {data:correct_hrefs}) 
    
        end 
    end
end
# importing userReviews file without using pandas
import csv

with open('userReviews.csv',newline='') as f:
    reader = csv.reader(f, delimiter=";")
    list_X = list(reader)
# list Y presents the reviews only for sherlock holmes
list_Y = list(filter(lambda c: c[0] == "sherlock-holmes", list_X))

with open('sherlockholmesreviews.csv','w',newline='') as f:
    writer = csv.writer(f)
    writer.writerows(list_Y)
#author list contains only authors who reviews sherlock holmes
list_Z = []
author_list = []
for i in list_Y:
    author_list.append(i[2])
for row in list_X:
    author = row[2]
    if(author in author_list):
        list_Z.append([author, row[0]])
print(list_Z)
#list Z contains all movies which were reviewed by sherlock holmes reviews authors
with open('list_Z.csv','w',newline='') as f:
    writer = csv.writer(f)
    writer.writerows(list_Z)



        
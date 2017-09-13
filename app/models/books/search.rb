 module Books
   class Search < Books::Book
     searchkick

     def search_data
       {
         title: title,
         description: description,
         authors: authors.map(&:name),
         tags: tags.map(&:name)
       }
     end
   end
 end
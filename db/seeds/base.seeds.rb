%w{Industry Country Province City Skill SkillCategory}.each{|x| eval(x).delete_all}
%w{Industry Country Province City Skill}.each{|x| eval(x).populate}

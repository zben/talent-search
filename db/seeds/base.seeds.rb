%w{Country Province City Skill SkillCategory}.each{|x| eval(x).delete_all}
%w{Country Province City}.each{|x| eval(x).populate}
Skill.populate

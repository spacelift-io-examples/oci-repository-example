package spacelift

approve { input.run.type == "PROPOSED" }
reject  { count(input.reviews.current.rejections) > 0 }
reject  { input.run.type != "PROPOSED" }

sample { true }
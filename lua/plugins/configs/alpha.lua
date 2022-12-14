local status_ok, alpha = pcall(require, "alpha")

if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[]],
  [[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ]],
  [[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
  [[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ]],
  [[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
  [[          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
  [[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
  [[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
  [[ ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
  [[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ]],
  [[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
  [[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
  [[]],
}

local configHome = vim.fn.stdpath("config")
dashboard.section.buttons.val = {
	dashboard.button("<leader>ff", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("<leader>fr", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("<leader>fw", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("c", "  Configuration", ":cd " .. configHome .. "<CR> :e init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local quotes = {
  "When something is important enough, you do it even if the odds are not in your favor.",
  "It always seems impossible until it's done.",
  "Life is 10% what happens to you and 90% how you react to it.",
  "Optimism is the faith that leads to achievement. Nothing can be done without hope and confidence.",
  "If you can dream it, you can do it.",
  "What you do today can improve all your tomorrows.",
  "A good plan violently executed now is better than a perfect plan executed next week.",
  "Act as if what you do makes a difference. It does.",
  "With the new day comes new strength and new thoughts.",
  "Well done is better than well said.",
  "Keep your eyes on the stars, and your feet on the ground.",
  "Knowing is not enough; we must apply. Willing is not enough; we must do.",
  "Setting goals is the first step in turning the invisible into the visible.",
  "Aim for the moon. If you miss, you may hit a star.",
  "Don't watch the clock; do what it does. Keep going.",
  "Either you run the day or the day runs you.",
  "A somebody was once a nobody who wanted to and did.",
  "The key is to keep company only with people who uplift you, whose presence calls forth your best.",
  "Be kind whenever possible. It is always possible.",
  "Your talent is God's gift to you. What you do with it is your gift back to God.",
  "Things do not happen. Things are made to happen.",
  "Change your life today. Don't gamble on the future, act now, without delay.",
  "In order to succeed, we must first believe that we can.",
  "When one must, one can.",
  "You are never too old to set another goal or to dream a new dream.",
  "A creative man is motivated by the desire to achieve, not by the desire to beat others.",
  "Opportunity does not knock, it presents itself when you beat down the door.",
  "Never give up, for that is just the place and time that the tide will turn.",
  "If you're going through hell, keep going.",
  "It does not matter how slowly you go as long as you do not stop.",
  "Good, better, best. Never let it rest. 'Til your good is better and your better is best.",
  "Start where you are. Use what you have. Do what you can.",
  "Ever tried. Ever failed. No matter. Try Again. Fail again. Fail better.",
  "Quality is not an act, it is a habit.",
  "The secret of getting ahead is getting started.",
  "If you fell down yesterday, stand up today.",
  "There is only one corner of the universe you can be certain of improving, and that's your own self.",
  "Always do your best. What you plant now, you will harvest later.",
  "You will never win if you never begin.",
  "We should not give up and we should not allow the problem to defeat us.",
  "Hitch your wagon to a star.",
  "When you reach the end of your rope, tie a knot in it and hang on.",
  "You can't cross the sea merely by standing and staring at the water.",
  "Set your goals high, and don't stop till you get there.",
  "What you get by achieving your goals is not as important as what you become by achieving your goals.",
  "Perseverance is not a long race; it is many short races one after the other.",
  "Problems are not stop signs, they are guidelines.",
  "The past cannot be changed. The future is yet in your power.",
  "Be miserable. Or motivate yourself. Whatever has to be done, it's always your choice.",
  "No bird soars too high if he soars with his own wings.",
  "Never complain and never explain.",
  "We may encounter many defeats but we must not be defeated.",
  "Only I can change my life. No one can do it for me.",
  "The most effective way to do it, is to do it.",
  "Don't think, just do.",
  "You can't build a reputation on what you are going to do.",
  "A goal is a dream with a deadline.",
  "The harder the conflict, the more glorious the triumph.",
  "Every exit is an entry somewhere else.",
  "Without hard work, nothing grows but weeds.",
  "You must take action now that will move you towards your goals. Develop a sense of urgency in your life.",
  "Expect problems and eat them for breakfast.",
  "I've found that luck is quite predictable. If you want more luck, take more chances. Be more active. Show up more often.",
  "You can never quit. Winners never quit, and quitters never win.",
  "I really believe that everyone has a talent, ability, or skill that he can mine to support himself and to succeed in life.",
  "Press forward. Do not stop, do not linger in your journey, but strive for the mark set before you.",
  "If you want to conquer fear, don't sit home and think about it. Go out and get busy.",
  "Be gentle to all and stern with yourself.",
  "To begin, begin.",
  "Wherever you are - be all there.",
  "Arriving at one goal is the starting point to another.",
  "I attribute my success to this - I never gave or took any excuse.",
  "No matter how many goals you have achieved, you must set your sights on a higher one.",
  "The hardships that I encountered in the past will help me succeed in the future.",
  "You can't wait for inspiration. You have to go after it with a club.",
  "Don't give up. Don't lose hope. Don't sell out.",
  "Even if you fall on your face, you're still moving forward.",
  "The more things you do, the more you can do.",
  "Small deeds done are better than great deeds planned.",
  "Always desire to learn something useful.",
  "After a storm comes a calm.",
  "I am not afraid... I was born to do this.",
  "You just can't beat the person who never gives up.",
  "Do you want to know who you are? Don't ask. Act! Action will delineate and define you.",
  "The ultimate aim of the ego is not to see something, but to be something.",
  "Do not wait to strike till the iron is hot; but make it hot by striking.",
  "One way to keep momentum going is to have constantly greater goals.",
  "Follow your inner moonlight; don't hide the madness.",
  "Either I will find a way, or I will make one.",
  "You simply have to put one foot in front of the other and keep going. Put blinders on and plow right ahead.",
  "I know where I'm going and I know the truth, and I don't have to be what you want me to be. I'm free to be what I want.",
  "Perseverance is failing 19 times and succeeding the 20th.",
  "The will to succeed is important, but what's more important is the will to prepare.",
  "Motivation is the art of getting people to do what you want them to do because they want to do it.",
  "If you want to succeed you should strike out on new paths, rather than travel the worn paths of accepted success.",
  "Do your work with your whole heart, and you will succeed - there's so little competition.",
  "The first step toward success is taken when you refuse to be a captive of the environment in which you first find yourself.",
  "Do something wonderful, people may imitate it.",
  "Pursue one great decisive aim with force and determination.",
  "Step by step and the thing is done.",
  "The people who influence you are the people who believe in you.",
  "To be a good loser is to learn how to win.",
  "Go big or go home. Because it's true. What do you have to lose?",
}

local function footer()
  math.randomseed(os.time())
  local rand_index = math.random(#quotes)
	return quotes[rand_index]
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

alpha.setup(dashboard.opts)

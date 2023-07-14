class AnswersController < ApplicationController
    # skip_before_action :verify_authenticity_token

 
    def index
        answer = Answer.all
        if answer.empty?
            render json:
            {
                message: "NO answer details found..."
            }, status: 404
        else
            render json:
            {
                message: "All answers detil found!",
                answer: answer
            }, status: 200
        end
    end

    def show
        answer = set_answer
        if answer
            render json:
            {
                message: "Specific answer detail retrived..",
                answer: answer
            }, status: 200
        else
            render json:
            {
                message: "No detail found for specified id.."
            }, status: 404
        end
    end

    def create
        
        answer = Answer.create(answer_params)
        if answer.save
            render json:
            {
                message: "New answer details saved successfully..",
                answer: answer
            }, status: 201
        else
            render json:
            {
                message: "Failed to create/Save new anser detail"
            }, status: 400
        end
    end

    def update
        answer = set_answer
        if answer.update(answer_params)
            render json:
            {
                message: "Details updated successfully!",
                answer: answer
            }, status: 200
        else
            render json:
            {
                message: "Failed to update the details",
                errors: answer.errors.full_messages
            }, status: 422
        end
    end


    def submit_answer
        jwt_payload = JWT.decode(request.headers['token'], Rails.application.credentials.fetch(:secret_key_base)).first
        current_user = User.find(jwt_payload['sub'])
        if current_user.role == "user"
          answer_params = params[:answer]
          question_id = answer_params[:question_id]
          answer = answer_params[:answer]
          user_id = current_user[:id]
      
          store = {
            1 => "string",
            2 => "0",
            3 => "new",
            4 => "both a and b",
            5 => "+",
            6 => "5",
            7 => "final int num = 10",
            8 => "int num = Integer.parseInt(10)",
            9 => "It exits the entire loop.",
            10 => "internal",
            11 => "void myMethod(int x, int y)",
            12 => "11",
            13 => "class MyClass",
            14 => "false",
            15 => "for",
            16 => "70",
            17 => "It is used to ensure mutually exclusive access to shared resources among multiple threads",
            18 => "new",
            19 => "Serializable",
            20 => "int",
            21 => "A constructor can be declared as private.",
            22 => "TreeMap",
            23 => "super",
            24 => "protected",
            25 => "final",
            26 => "1variable",
            27 => "package",
            28 => "virtual",
            29 => "Static constructor",
            30 => "exit",
            31 => "package-private",
            32 => "Final class",
            33 => "It refers to the current instance of a class.",
            34 => "It is used to perform a runtime assertion check.",
            35 => "Static methods can only access static variables.",
            36=> "123variable",
            37 => "8",
            38 => "def my_function():",
            39 => "list",
            40 => "3",
            41 => "len(list)",
            42 => "open(data.txt" "w)",
            43 => "**",
            44 => "HelloWorld",
            45 => "int(str)",
            46 => "A generator object.",
            47 => "def",
            48 => "input()",
            49 => "pop()",
            50 => "key in dictionary",
            51 => "round()",
            52 => "list",
            53 => "sorted()",
            54 => "os.path.exists(file_path)",
            55 => "raise",
            56 => "A generator object that produces numbers on-the-fly",
            57 => "os.path.isfile(file_path)",
            58 => "It does nothing; it's a null operation.",
            59 => "Lists are mutable, while tuples are immutable.",
            60 => "file = open(data.txt w)",
            61 => "It checks if two objects have the same identity.",
            62 => "A web development framework",
            63 => "new",
            64 => "rails new <application_name>",
            65 => "schema.rb",
            66 => "To create database tables",
            67 => "app/views",
            68 => "app/views",
            69 => "routes.rb",
            70 => "Using the rails generate controller command",
            71 => "rails server",
            72 => "To pass data between views and controllers",
            73 => "rails generate model",
            74 => "To specify the application's dependencies",
            75 => "Using the has_many association",
            76 => "rails console",
            77 => "around_update",
            78 => "rails generate view",
            79 => "array",
            80 => "To render a view template"
          }
      
          expected_answer = store[question_id]
          expected_result = expected_answer == answer
      
          ans = Answer.create(
            question_id: question_id,
            correctAnswer: expected_answer,
            userAnswer: answer,
            user_id: user_id,
            expectedResult: expected_result
          )
      
          if ans.save
            correct_answer_count = Answer.where(user_id: user_id, expectedResult: true).count
            render json: 
            { message: "Answers submitted successfully!!!",
              Total_correct_answers: correct_answer_count 
            }, status: 200
          else
            render json: 
            { message: "Answer already submitted..."
            }, status: 400
          end
        else
          render json: 
          { success: false, error: "Please complete user authentication..." },
           status: 400
        end
      end
      
      

    private
    def set_answer
        answer = Answer.find_by(id: params[:id])
        if answer
            return answer
        end
    end

    def answer_params
        params.require(:answer).permit(:correctAnswer,:userAnswer,:expectedResult,:user_id,:question_id)
    end

end
require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "assigns all users" do
    	get 'index'
    	expect(assigns(:users)).not_to be_nil
    end
  end

  describe "GET 'show'" do
    before :each do
    	@user = double('User', id: 1,
                     first_name: 'Hermionie',
                     last_name: 'Granger',
                     email: 'hgranger@hogwarts.ac.uk',
                    )
      @projects = [
          mock_model(Project, friendly_id: 'title-1', title: 'Title 1'),
          mock_model(Project, friendly_id: 'title-2', title: 'Title 2'),
          mock_model(Project, friendly_id: 'title-3', title: 'Title 3')
      ]
      User.stub(find: @user)
      @user.stub(:following_by_type).and_return(@projects)
    end

    it "assigns a user instance" do
  		get 'show', id: @user.id
  		expect(assigns(:user)).not_to be_nil
    end

    it "renders the show view" do
      get 'show', id: @user.id
      expect(response).to render_template :show
    end

    context "with followed projects" do
      before :each do

      end

      it "assigns a list of project being followed" do
        get 'show', id: @user.id
        expect(assigns(:users_projects)).to eq(@projects)
      end
    end
  end

end

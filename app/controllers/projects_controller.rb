class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
  
  def dashboard
    @project = Project.find_by_id(params[:project_id])
    
    @status = params[:status] if Part::STATUS_MAP.has_key?(params[:status])
  end
  
  def open_orders
    @project = Project.find_by_id(params[:project_id])
    @no_vendor_order_items = OrderItem.where(:order_id => nil, :project_id => params[:project_id])
    @open_orders = Order.where(:status => "open").where(:project_id => params[:project_id]).order(:vendor_name, :ordered_at)
    @ordered_orders = Order.where(:status => "ordered").where(:project_id => params[:project_id]).order(:vendor_name, :ordered_at)
    @received_orders = Order.where(:status => "received").where(:project_id => params[:project_id]).order(:vendor_name, :ordered_at)
    @show_new_item_form = params[:new_item] == "true"
    
    @orders = Order.where("project_id = ? and status != ?",params[:project_id],'open').all
    @orders_by_vendor = @orders.inject({}) do |map, order|
      map[order.vendor_name] ||= []
      map[order.vendor_name] << order
      map
    end

    @orders_by_purchaser = @orders.inject({}) do |map, order|
      map[order.paid_for_by] ||= {}
      map[order.paid_for_by][:reimbursed] ||= 0
      map[order.paid_for_by][:outstanding] ||= 0
      if order.reimbursed == 1
        map[order.paid_for_by][:reimbursed] += order.total_cost
      else
        map[order.paid_for_by][:outstanding] += order.total_cost
      end
      map
    end
  end
  def stats_orders
  end
  def edit_order
  end
  def create_order_items
    @project = Project.find_by_id(params[:project_id])
    if params[:vendor].nil? || params[:vendor].empty?
      order_id = nil
    else
      order = Order.where(:project_id => @project.id, :vendor_name => params[:vendor],
                          :status => "open").first
      if order.nil?
        order = Order.new(:project_id => @project.id, :vendor_name => params[:vendor], :status => "open", :reimbursed=>0)
        order.save
      end
      order_id = order.id
    end

    item = OrderItem.new(:project_id => @project.id, :order_id => order_id, :quantity => params[:quantity].to_i,
                     :part_number => params[:part_number], :description => params[:description],
                     :unit_cost => params[:unit_cost].to_f, :notes => params[:notes])
    item.save
    render :class=>:projects, :method=> :open_orders, :template=>"projects/open_orders", :project_id => @project.id
  end
end

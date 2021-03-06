defmodule CodeCorps.ProjectViewTest do
  use CodeCorps.ConnCase, async: true

  import Phoenix.View, only: [render: 3]

  test "renders all attributes and relationships properly" do
    organization = insert(:organization)
    project = insert(:project, organization: organization, total_monthly_donated: 5000)

    donation_goal = insert(:donation_goal, project: project)
    project_category = insert(:project_category, project: project)
    project_skill = insert(:project_skill, project: project)
    stripe_connect_plan = insert(:stripe_connect_plan, project: project)
    task_list = insert(:task_list, project: project)
    task = insert(:task, project: project, task_list: task_list)

    rendered_json = render(CodeCorps.ProjectView, "show.json-api", data: project)

    expected_json = %{
      "data" => %{
        "attributes" => %{
          "description" => project.description,
          "donations-active" => true,
          "icon-large-url" => CodeCorps.ProjectIcon.url({project.icon, project}, :large),
          "icon-thumb-url" => CodeCorps.ProjectIcon.url({project.icon, project}, :thumb),
          "inserted-at" => project.inserted_at,
          "long-description-body" => project.long_description_body,
          "long-description-markdown" => project.long_description_markdown,
          "slug" => project.slug,
          "title" => project.title,
          "total-monthly-donated" => project.total_monthly_donated,
          "updated-at" => project.updated_at,
        },
        "id" => project.id |> Integer.to_string,
        "relationships" => %{
          "donation-goals" => %{"data" => [
            %{
              "id" => donation_goal.id |> Integer.to_string,
              "type" => "donation-goal"
            }
          ]},
          "organization" => %{
            "data" => %{
              "id" => organization.id |> Integer.to_string,
              "type" => "organization"
            }
          },
          "project-categories" => %{
            "data" => [
              %{
                "id" => project_category.id |> Integer.to_string,
                "type" => "project-category"
              }
            ]
          },
          "project-skills" => %{
            "data" => [
              %{
                "id" => project_skill.id |> Integer.to_string,
                "type" => "project-skill"
              }
            ]
          },
          "stripe-connect-plan" => %{
            "data" => %{
              "id" => stripe_connect_plan.id |> Integer.to_string,
              "type" => "stripe-connect-plan"
            }
          },
          "task-lists" => %{
            "data" => [
              %{
                "id" => task_list.id |> Integer.to_string,
                "type" => "task-list"
              }
            ]
          },
          "tasks" => %{
            "data" => [
              %{
                "id" => task.id |> Integer.to_string,
                "type" => "task"
              }
            ]
          }
        },
        "type" => "project",
      },
      "jsonapi" => %{
        "version" => "1.0"
      }
    }

    assert rendered_json == expected_json
  end

  test "renders donations-active true when project has donations and a plan" do
    project = insert(:project)
    insert(:donation_goal, project: project)
    insert(:stripe_connect_plan, project: project)

    conn = Phoenix.ConnTest.build_conn
    rendered_json = render(CodeCorps.ProjectView, "show.json-api", data: project, conn: conn)
    assert rendered_json["data"]["attributes"]["donations-active"] == true
  end

  test "renders donations-active false when project has donations and no plan" do
    project = insert(:project)
    insert(:donation_goal, project: project)

    conn = Phoenix.ConnTest.build_conn
    rendered_json = render(CodeCorps.ProjectView, "show.json-api", data: project, conn: conn)
    assert rendered_json["data"]["attributes"]["donations-active"] == false
  end

  test "renders donations-active false when project has no donations and no plan" do
    project = insert(:project)

    conn = Phoenix.ConnTest.build_conn
    rendered_json = render(CodeCorps.ProjectView, "show.json-api", data: project, conn: conn)
    assert rendered_json["data"]["attributes"]["donations-active"] == false
  end
end

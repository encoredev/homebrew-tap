class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230829"
    checksums = {
        "darwin_arm64" => "7614db82c99c7df843a78d0f48961332f064dc7e6987b5e4db6e36f0e1e4549e",
        "darwin_amd64" => "60e062b2b257dd2ab34df032915cf733ca3787a642d935f0bc70ff60fd50936b",
        "linux_arm64"  => "8118886906b6aa68556ac3f05af352822a5c0b3415a17f515297d416b7384ee5",
        "linux_amd64"  => "bfba10f40fd212f120d6a393472c481f630f33c28e587ac0c3b71be28f5342d0",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end

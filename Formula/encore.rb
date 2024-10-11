class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.9"
    checksums = {
        "darwin_arm64" => "689e4a5550a3d4e3c57fe4cf225fe8abf7d63f9f4744852dc6d3ef3ba19a3f0f",
        "darwin_amd64" => "70844d2804c1ac8ffd7b2c792e8921e1959eddf06255ad88c67dafae76fd8b54",
        "linux_arm64"  => "8dbe6a1721cb105dd594cacf34e37081c8160ee20c14e3b014a0aa405f414d3d",
        "linux_amd64"  => "cfd7840b4af0886a638afd892e80d161ee1a841cadf23765a61e295c1e26ec1f",
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

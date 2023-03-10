class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230310"
    checksums = {
        "darwin_arm64" => "06389fe7aadc596d6d740917df02cda82db77d9693348a8ece6b94ddbb280045",
        "darwin_amd64" => "38d4389e207444e9e960ca97c26e4495bf2c64ed5443f15c95cb27f901695ebd",
        "linux_arm64"  => "f3627168ca0c8c859aa9c46e7c742fcbe969cdc7ca23ff203d83dba4af58e181",
        "linux_amd64"  => "287577dce0c539faf731a58cad5193c19fe69187350fc170baa01e053ba2fe1f",
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

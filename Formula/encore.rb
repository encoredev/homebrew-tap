class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.6"
    checksums = {
        "darwin_arm64" => "d37ae743ceb938197cbc6c954d18aefa5f59dfda7878fa6a89815688cfcb3e1e",
        "darwin_amd64" => "7a4f5e67a93f7b68c2212b20ceb0d489aa70c3af17c92308c11101440326abbe",
        "linux_arm64"  => "5480296fe0ae695b833cc35a4d7be6131d1c9b92aca831c7c0d14584a4fc3590",
        "linux_amd64"  => "2d5cd65ad98cdbbe855b4ae88b3b4febfbf393b31660a249bf41037603aad2bf",
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

class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.5"
    checksums = {
        "darwin_arm64" => "5f59bb24274e8a9c77ba1d7364564a9bce94b7aae3e525d631b73aced3d6973b",
        "darwin_amd64" => "cd3b432add98f1140cad61be39f8e03cb9e586386f26debe756ecce8dea861ad",
        "linux_arm64"  => "3ee4a82923f4373df2c349f5214a68b440bd1cd11fa74b45c9e29715ad8c6caa",
        "linux_amd64"  => "9c401705c51ba1e43f2b7bc465719d3e4acc37d548dd781793ec1ccd581bf626",
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

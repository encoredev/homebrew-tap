class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.5"
    checksums = {
        "darwin_arm64" => "ed4f6292bf0f17dd54c8280aab177b943651fcfe8ab7b5c918ceabb8df95bcaa",
        "darwin_amd64" => "ef1361ea2ab1e52e8b85f09738a8305eb5dc8dc62877eeb6dda4817abdf0b2c3",
        "linux_arm64"  => "d547e10125b6b042d7d13a98518d9f70ecfb118f9e04708b79e62e8605637f38",
        "linux_amd64"  => "f432ee3302559d13a76fd9e2eca5413e6c22d2626717942c031daec3d8a5d26d",
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

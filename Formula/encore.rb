class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.37.2"
    checksums = {
        "darwin_arm64" => "0c1530d6c3ae6799a2a5479fcfb4818b1c1a0c528af57d631b156aaab4596cc2",
        "darwin_amd64" => "23960b9079d0ce0bb1f5a21096a2ce23fb56d39184b0125e23babb9ab0bc7720",
        "linux_arm64"  => "4c6d3719c1423dcc9c5cd98d3833a79f2d202fa458d392ce3e823b62a4963637",
        "linux_amd64"  => "0924eebe5dc0dc90306f67440342d802d7b9612b86db5c55c9693dd1c32ab677",
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
